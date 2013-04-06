class AnimesController < ApplicationController
  def index
    params[:state] ||= :enabled
    self.fetch_animes
    @anime = @animes.first || @animes.new
    render :action=>:show
  end
  
  def show
    params[:state] ||= :all
    self.fetch_animes
    @anime = @animes.find(params[:id])
  end
  
  def update
    @anime = Anime.find(params[:id])
    @anime.update_attributes(params[:anime])
    state = params[:state].to_s.intern == :all ? :all : @anime.enable == 1 ? :enabled : :disabled
    redirect_to anime_path(@anime, :state=>state)
  end
  
  def video
    @anime = Anime.find(params[:id])
    url = @anime.video_url
    return render :status=>404 if url.nil?
    url += '&autoplay=1' if params.has_key?(:autoplay)
    redirect_to url
  end
  
  def site
    @anime = Anime.find(params[:id])
    return render :status=>404 if @anime.site_url.nil?
    redirect_to @anime.site_url
  end
  
  def thumbnail
    @anime = Anime.find(params[:id])
    return :status=>404 if @anime.fetch_image.nil?
    send_file @anime.image_path(:thumbnail), :type=>'image/jpeg', :disposition=>'inline'
  end
  
  def image
    @anime = Anime.find(params[:id])
    return :status=>404 if @anime.fetch_image.nil?
    send_file @anime.image_path(:original), :type=>'image/jpeg', :disposition=>'inline'
  end
  
  def suggested_image_urls
    @anime = Anime.find(params[:id])
    render :json=> @anime.search_image_urls
  end
  
  def suggested_video_urls
    @anime = Anime.find(params[:id])
    render :json=> @anime.search_video_urls
  end
  
  def suggested_site_urls
    @anime = Anime.find(params[:id])
    render :json=> @anime.search_site_urls
  end
  
  protected
  
  def fetch_animes
    @animes = Anime.ordered
    case params[:state].to_s.intern
      when :enabled  then @animes = @animes.enabled
      when :disabled then @animes = @animes.disabled
    end
  end
end
