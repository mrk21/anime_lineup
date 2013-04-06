module ChannelsHelper
  def channel_init
    @_airtime_groups = @channel.airtimes.group_by{|r| r.day_name}
  end
end
