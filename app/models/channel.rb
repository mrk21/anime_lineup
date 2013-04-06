class Channel < ActiveRecord::Base
  has_many :airtimes, :include=>:anime, :dependent=> :destroy
  has_many :animes, :through=>:airtimes
  accepts_nested_attributes_for :airtimes
  
  scope :ordered , lambda{ order [:no,:name] }
  scope :enabled , lambda{ where :enable=>1 }
  scope :disabled, lambda{ where :enable=>0 }
end
