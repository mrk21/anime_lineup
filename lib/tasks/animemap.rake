namespace :animemap do
  desc 'Initialization of DB, and importing from animemap.net'
  task :init => ['db:drop', 'db:create', 'db:migrate', :import]
  
  desc 'Importing from animemap.net'
  task :import => :environment do
    Animemap::Lineup.import
  end
end
