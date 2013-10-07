# -*- coding: utf-8 -*-

namespace :bugfix do
  desc "#211におけるバグの修正"
  task :fix_211 => :environment do
    Anime.update_all("video_url=REPLACE(video_url,'http://','https://')")
  end
end
