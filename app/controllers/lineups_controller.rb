class LineupsController < ApplicationController
  def show
    params[:id] ||= Airtime.day_names(Airtime.today.wday)
    @channels = Channel.enabled.ordered
    @airtimes = Airtime.enabled.ordered.on_day(params[:id])
  end
end
