class GoogleSearch::Image < GoogleSearch::Base
  def self.search_name
    :images
  end
  
  def self.params_with_image_options(keyword, params={})
    self.params_without_image_options(keyword, params).merge(:imgc=>'color')
  end
  
  class << self
    alias_method_chain :params, :image_options
  end
end
