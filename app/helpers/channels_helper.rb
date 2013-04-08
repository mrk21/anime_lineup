module ChannelsHelper
  def channel_init
    @_airtime_groups = @channel.airtimes_under_enabled_animes.group_by{|r| r.day_name}
  end
end
