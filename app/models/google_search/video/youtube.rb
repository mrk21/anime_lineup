class GoogleSearch::Video::Youtube < GoogleSearch::Video
  def self.find_by_keyword_with_youtube(keyword, params={})
    self.find_by_keyword_without_youtube("#{keyword} site:www.youtube.com", params)
  end
  
  class << self
    alias_method_chain :find_by_keyword, :youtube
  end
  
  def embedded_url
    uri = self.playUrl
    return nil if uri.blank?
    video_id = uri.sub(/^http:\/\/youtube.googleapis.com\/v\/([^&?]+).*$/,'\1')
    return nil if video_id.blank?
    "http://www.youtube-nocookie.com/embed/#{id}?rel=0"
  end
end
