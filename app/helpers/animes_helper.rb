module AnimesHelper
  def anime_init
    @_airtime_groups = @anime.airtimes.group_by{|r| r.day_name}
  end
  
  def anime_image_tag(anime, options={})
    return '' if anime.image_url.blank?
    options.symbolize_keys!
    url_params = options.delete(:url_params)
    image_tag image_anime_path(anime, url_params), options
  end
  
  def anime_video_link_to(anime, content, options={})
    return '' if anime.video_url.blank?
    options.symbolize_keys!
    options[:target] ||= '_blank'
    url_params = options.delete(:url_params)
    url_params ||= {}
    url_params[:autoplay] ||= 1
    link_to content, video_anime_path(anime, url_params), options
  end
  
  def anime_site_link_to(anime, content, options={})
    return '' if anime.site_url.blank?
    options.symbolize_keys!
    options[:target] ||= '_blank'
    url_params = options.delete(:url_params)
    link_to content, site_anime_path(anime, url_params), options
  end
  
  def anime_video_tag(anime, options={})
    return '' if anime.video_url.blank?
    options.symbolize_keys!
    options[:width] ||= 640
    options[:height] ||= 360
    options[:frameborder] ||= 0
    options[:allowfullscreen] ||= ''
    options[:src] = video_anime_path(anime, options.delete(:url_params))
    content_tag :iframe, nil, options
  end
end
