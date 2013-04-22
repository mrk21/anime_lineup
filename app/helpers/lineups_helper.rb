module LineupsHelper
  def init_lineup
    min = @airtimes.min{|r| r.start_time}.start_time_h - 4 rescue 20
    max = @airtimes.max{|r| r.start_time}.start_time_h + 4 rescue 24
    
    @_timetable = (min..max)
    @_airtime_timetables = @airtimes.group_by{|r| r.start_time_h}
    @_airtime_groups = @airtimes.group_by{|r| r.channel.id}
    @_airtime_groups.each do |k,v|
      @_airtime_groups[k] = v.sort{|a,b| a.start_time <=> b.start_time}.group_by{|r| r.start_time_h}
    end
  end
  
  def current_airtimes(channel_id, time)
    ((@_airtime_groups[channel_id]||{})[time]||[])
  end
  
  def current_day?(day)
    params[:id].to_s.intern == day.to_s.intern
  end
  
  def has_airtimes?(time)
    @_airtime_timetables[time]
  end
  
  def airtime_state_class(airtime)
    airtime.state_name.to_s.gsub('_','-')
  end
  
  def next_day
    move_day(1)
  end
  
  def prev_day
    move_day(-1)
  end
  
  def move_day(value)
    Airtime.day_names((Airtime.days(params[:id]) + value) % Airtime.days.size)
  end
end
