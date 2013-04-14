class Channel < ActiveRecord::Base
  has_many :airtimes, :include=>:anime, :dependent=> :destroy
  has_many :animes, :through=>:airtimes
  accepts_nested_attributes_for :airtimes, :allow_destroy=>true
  
  has_many :airtimes_under_enabled_animes, :class_name=>Airtime, :include=>:anime, :conditions=>Anime.arel_table[:enable].eq(1)
  has_many :enabled_animes, :source=>:anime, :through=>:airtimes_under_enabled_animes
  
  scope :ordered , lambda{ order [:no,:name] }
  scope :enabled , lambda{ where :enable=>1 }
  scope :disabled, lambda{ where :enable=>0 }
end
