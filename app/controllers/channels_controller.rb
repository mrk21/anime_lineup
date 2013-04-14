class ChannelsController < ApplicationController
  def index
    params[:state] ||= :enabled
    self.fetch_channels
    @channel = @channels.first || @channels.new
    render :action=>:show
  end
  
  def show
    params[:state] ||= :all
    self.fetch_channels
    @channel = @channels.find(params[:id])
  end
  
  def create
    @channel = Channel.create(params[:channel])
    redirect_to channel_path(@channel)
  end
  
  def update
    @channel = Channel.find(params[:id])
    @channel.update_attributes(params[:channel])
    state = params[:state].to_s.intern == :all ? :all : @channel.enable == 1 ? :enabled : :disabled
    redirect_to channel_path(@channel, :state=>state)
  end
  
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    redirect_to channels_path
  end
  
  protected
  
  def fetch_channels
    @channels = Channel.ordered
    case params[:state].to_s.intern
      when :enabled  then @channels = @channels.enabled
      when :disabled then @channels = @channels.disabled
    end
  end
end
