namespace :database do
  desc "Copy production database to local"
  task :sync => :environment do
    system 'sudo mongodump -h hydra.mongohq.com:10085 -d smartstox-cms-small -u cms -p Ys4RPNV72DEB9e5P -o /data/backups/'
    system 'sudo mongorestore -h localhost --drop -d smartstox-cms-dev /data/backups/smartstox-cms-small/' 
  end
end