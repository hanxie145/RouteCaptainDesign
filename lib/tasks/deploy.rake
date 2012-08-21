task :deploy do
  Rake::Task["assets:precompile"].reenable
  Rake::Task["assets:precompile"].invoke
end
