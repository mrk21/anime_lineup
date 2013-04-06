class GoogleSearch::Base < ActiveResource::Base
  class Format
    include ActiveResource::Formats::JsonFormat
    
    def decode_with_results(json)
      data = decode_without_results(json)
      data['responseData']['results'] rescue []
    end
    alias_method_chain :decode, :results
  end
  
  self.site = 'http://ajax.googleapis.com'
  self.format = Format.new
  
  def self.find_by_keyword(keyword, params={})
    name = self.search_name
    query = self.params(keyword, params).each_pair.map{|k,v| "#{k}=#{v}"}.join("&")
    url = "/ajax/services/search/#{name}?#{query}"
    self.find(:all, :from=> URI.encode(url))
  end
  
  def self.params(keyword, params={})
    params.symbolize_keys!
    params[:start] ||= 0
    {:v=>'1.0', :q=>keyword, :hl=>'ja', :safe=>'off'}.merge(params)
  end
  
  def self.search_name
  end
end
