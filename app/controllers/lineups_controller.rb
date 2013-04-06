class LineupsController < ApplicationController
  def show
    params[:id] ||= Airtime.day_names(Time.now.wday)
    @channels = Channel.enabled.ordered
    @airtimes = Airtime.enabled.ordered.on_day(params[:id])
  end
end
