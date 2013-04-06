module ApplicationHelper
  def format_time(time)
    "%02d:%02d" % [time/60, time%60]
  end
end
