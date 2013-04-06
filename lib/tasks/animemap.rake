namespace :animemap do
  desc "Initialization of DB, and importing from 'http://animemap.net'"
  task :init => ['db:drop', 'db:create', 'db:migrate', :import]
  
  desc "Importing from 'http://animemap.net'"
  task :import do
    Animemap::Lineup.import
  end
end
