require 'cgi'
require 'open-uri'
require 'RMagick'

class Anime < ActiveRecord::Base
  has_many :airtimes, :include=>:channel, :dependent=> :destroy
  has_many :channels, :through=>:airtimes
  accepts_nested_attributes_for :airtimes
  
  has_many :airtimes_under_enabled_channels, :class_name=>Airtime, :include=>:channel, :conditions=>Channel.arel_table[:enable].eq(1)
  has_many :enabled_channels, :source=>:channel, :through=>:airtimes_under_enabled_channels
  
  IMAGE_THUMBNAIL_SIZE = 250
  IMAGE_BASE_PATH = File.join(Rails.root, 'tmp/cache/images')
  
  scope :ordered , lambda{ order [:rating,:title] }
  scope :enabled , lambda{ where :enable=>1 }
  scope :disabled, lambda{ where :enable=>0 }
  
  def image_path(type=:original)
    return nil if self.image_url.blank?
    path = File.join(IMAGE_BASE_PATH, [:anime, self.id, type].join('_'))
  end
  
  def fetch_image(is_force=false)
    return nil if self.image_url.blank?
    Dir::mkdir(IMAGE_BASE_PATH) unless File.exists? IMAGE_BASE_PATH
    
    original_path = image_path(:original)
    if is_force || !File.exists?(original_path) then
      open(self.image_url) do |source|
        open(original_path, "w+b") do |o|
          o.print source.read
        end
      end
    end
    
    thumbnail_path = image_path(:thumbnail)
    if is_force || !File.exists?(thumbnail_path) then
      image = Magick::Image.read(original_path).first
      image.resize_to_fill(IMAGE_THUMBNAIL_SIZE).write(thumbnail_path)
    end
    
    true
  end
  
  def search_images
    @search_images ||= GoogleSearch::Image.find_by_keyword(self.title)
    @search_images
  end
  
  def search_videos
    @search_videos ||= GoogleSearch::Video::Youtube.find_by_keyword(self.title)
    @search_videos
  end
  
  def search_sites
    @search_sites ||= GoogleSearch::Web.find_by_keyword(self.title)
    @search_sites
  end
  
  def search_image_urls
    @search_image_urls ||= self.search_images.map{|v| v.unescapedUrl rescue nil}.compact
    @search_image_urls
  end
  
  def search_video_urls
    @search_video_urls ||= self.search_videos.map{|v| v.embedded_url rescue nil}.compact
    @search_video_urls
  end
  
  def search_site_urls
    @search_site_urls ||= self.search_sites.map{|v| v.unescapedUrl rescue nil}.compact
    @search_site_urls
  end
  
  def autoset_image_url
    self.image_url = self.search_image_urls.first
    self
  end
  
  def autoset_video_url
    self.video_url = self.search_video_urls.first
    self
  end
  
  def autoset_site_url_and_description
    site = self.search_sites.first
    return self if site.nil?
    self.site_url = site.unescapedUrl
    self.description = site.content rescue ''
    self.description = CGI.unescapeHTML(self.description)
    self.description = ActionView::Base.full_sanitizer.sanitize(self.description) 
    self
  end
  
  def autoset
    self.autoset_image_url
    self.autoset_video_url
    self.autoset_site_url_and_description
  end
end
