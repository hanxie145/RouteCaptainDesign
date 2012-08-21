require 'bundler/capistrano'

default_run_options[:pty] = true
set :application,     "smartstoxemail"
set :scm,             :git
set :repository,      "https://bevanhunt@bitbucket.org/bevanhunt/smartstox-email.git"
set :user,            "bevanhunt"  # The server's user for deploys
set :scm_passphrase,  "s1t2o3x4$$$"  # The deploy user's password
set :branch,          "master"
set :migrate_target,  :current
ssh_options[:forward_agent] = true
set :rails_env,       "production"
set :deploy_to,       "/home/bevan/apps/smartstoxemail"
set :normalize_asset_timestamps, false

set :user,            "bevan"
set :group,           "www-data"
set :password,        "b1e2v3!@#"
set :use_sudo,        false
set :rvm_ruby_string, "1.9.2@emailify"
set :rvm_type, :user

role :web,    "96.126.96.192"
role :app,    "96.126.96.192"
role :db,     "96.126.96.192"

# Use our ruby-1.9.2-p290@my_site gemset
set :default_environment, {
    'RAILS_ENV' => 'production',
    'PATH' => "/usr/local/rvm/gems/ruby-1.9.2-p290@emailify/bin:/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin:/usr/local/rvm/rubies/ruby-1.9.2-p290/bin:/usr/local/rvm/bin:/root/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11",
    'GEM_HOME' => "/usr/local/rvm/gems/ruby-1.9.2-p290@emailify",
    'GEM_PATH' => "/usr/local/rvm/gems/ruby-1.9.2-p290@emailify:/usr/local/rvm/gems/ruby-1.9.2-p290@global",
    'RUBY_VERSION' =>  "ruby-1.9.2-p290"
}

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
    symlink
  end

  task :write_crontab do

  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git clean -xdf; git pull; git reset --hard #{branch};"
    finalize_update
    passenger::restart
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    passenger::restart
  end

  # keep for crontab (whenever)
  task :symlink do
  end

  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      rm -rf #{latest_release}/log #{latest_release}/public/system &&
      mkdir -p #{latest_release}/public &&
      mkdir -p #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log &&
      ln -s #{shared_path}/system #{latest_release}/public/system &&
      ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_paths = fetch(:public_children, %w(images stylesheets javascripts)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_paths} -exec touch -t #{stamp} {} ';'; true", :env => { "TZ" => "UTC" }
    end
  end

  namespace :passenger do
    desc "Restart of Passenger"
    task :restart, :except => { :no_release => true } do
      sudo "/etc/init.d/apache2 restart"
    end
  end

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end