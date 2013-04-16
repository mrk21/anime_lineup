class Airtime < ActiveRecord::Base
  belongs_to :anime
  belongs_to :channel
  
  DAYS = Hash[%W(sun mon tues wed thurs fri sat).each_with_index.map{|v,i| [v.intern, i]}]
  DAY_NAMES = DAYS.invert
  
  STATE_NEW = 0
  STATE_ON_AIR = 1
  STATE_FINISH = 2
  
  scope :enabled , lambda{ where(:enable=>1).where(Anime.arel_table[:enable].eq(1)).where(Channel.arel_table[:enable].eq(1)).includes([:anime, :channel]) }
  scope :disabled, lambda{ where(:enable=>0).   or(Anime.arel_table[:enable].eq(0)).   or(Channel.arel_table[:enable].eq(0)).includes([:anime, :channel]) }
  scope :ordered, lambda{ order [:day,:start_time] }
  
  scope :with_anime, lambda{ includes :anime }
  
  scope :on_day, lambda{|day|
    where(:day=> self.days(day).nil? ? day : self.days(day))
  }
  
  def self.today
    Time.now - 4.hour
  end
  
  def self.days(key=nil)
    key.nil? ? DAYS : DAYS[key.to_s.intern]
  end
  
  def self.day_names(key=nil)
    key.nil? ? DAY_NAMES : DAY_NAMES[key.to_i]
  end
  
  def day_name
    self.class.day_names(self.day)
  end
  
  def day_name=(val)
    self.day = self.class.days(val)
  end
  
  def start_time_h
    self.start_time / 60
  end
  
  def start_time_m
    self.start_time % 60
  end
end
