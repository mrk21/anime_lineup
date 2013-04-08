# -*- coding: utf-8 -*-

class Animemap::Lineup < ActiveResource::Base
  class Format
    include ActiveResource::Formats::XmlFormat
    
    def decode_with_results(xml)
      data = decode_without_results(xml)
      data['response']['item'] rescue []
    end
    alias_method_chain :decode, :results
  end
  
  self.site = 'http://animemap.net'
  self.format = Format.new
  
  self.schema = {
    'title'   => :string ,
    'url'     => :string ,
    'time'    => :string ,
    'station' => :string ,
    'state'   => :string ,
    'next'    => :date   ,
    'episode' => :integer,
    'cable'   => :integer,
    'today'   => :integer,
    'week'    => :string ,
  }
  
  # http://animemap.net/pages/api/
  <<-JS
    var data = "[";
    
    Array.prototype.forEach.call(document.querySelectorAll('table tbody tr td:nth-child(2) a'), function(dom){
      data += ':'+ dom.href.replace(/http:\/\/animemap.net\/api\/table\/(\w+).xml/, '$1') +',';
    });
    data += "]";
    
    console.log(data);
  JS
  REGIONS = [:hokkaidou,:aomori,:iwate,:miyagi,:akita,:yamagata,:fukushima,:ibaraki,:tochigi,:gunma,:saitama,:chiba,:tokyo,:kanagawa,:niigata,:toyama,:ishikawa,:fukui,:yamanashi,:nagano,:gifu,:shizuoka,:aichi,:mie,:shiga,:kyoto,:osaka,:hyogo,:nara,:wakayama,:tottori,:shimane,:okayama,:hiroshima,:yamaguchi,:tokushima,:kagawa,:ehime,:kochi,:fukuoka,:saga,:nagasaki,:kumamoto,:oita,:miyazaki,:kagoshima,:okinawa,]
  
  # http://animemap.net/time/station/
  <<-JS
    var currentGroup;
    var data = "{";
    
    Array.prototype.map.call(document.querySelectorAll('table.time-table tbody tr:not(:nth-child(1))'), function(rowDom){
      var group = rowDom.querySelector('td[rowspan]');
      var station;
      var stationAbbr;
      
      if (group) {
        currentGroup = group;
        station = rowDom.querySelector('td:nth-child(2) a');
        stationAbbr = rowDom.querySelector('td:nth-child(3)');
      }
      else {
        group = currentGroup;
        station = rowDom.querySelector('td:nth-child(1) a');
        stationAbbr = rowDom.querySelector('td:nth-child(2)');
      }
      if (!stationAbbr.innerHTML) stationAbbr = station;
      
      data += '"'+ stationAbbr.innerHTML +'"=>"'+ station.innerHTML +'",';
    });
    data += "}";
    
    console.log(data);
  JS
  CHANNELS = {"BS-TBS"=>"BS-TBS","IBC"=>"IBC岩手放送","RKB"=>"RKB毎日放送","TBS"=>"TBSテレビ","ITV"=>"あいテレビ","TUT"=>"チューリップテレビ","TUY"=>"テレビユー山形","TUF"=>"テレビユー福島","tys"=>"テレビ山口","KUTV"=>"テレビ高知","RCC"=>"中国放送","CBC"=>"中部日本放送","SBC"=>"信越放送","HBC"=>"北海道放送","MRO"=>"北陸放送","MBC"=>"南日本放送","OBS"=>"大分放送","MRT"=>"宮崎放送","BSS"=>"山陰放送","RSK"=>"山陽放送","BSN"=>"新潟放送","TBC"=>"東北放送","MBS"=>"毎日放送","RKK"=>"熊本放送","RBC"=>"琉球放送","NBC"=>"長崎放送","ATV"=>"青森テレビ","SBS"=>"静岡放送","ShowTime"=>"ShowTime","アニメイトTV"=>"アニメイトTV","アニメワン"=>"アニメワン","ニコニコ生放送"=>"ニコニコ生放送","バンダイチャンネル"=>"バンダイチャンネル","UTY"=>"テレビ山梨","EX"=>"テレビ朝日","KBC"=>"九州朝日放送","HTB"=>"北海道テレビ","HAB"=>"北陸朝日放送","NBN"=>"名古屋テレビ","OAB"=>"大分朝日放送","yab"=>"山口朝日放送","YTS"=>"山形テレビ","IAT"=>"岩手朝日テレビ","HOME"=>"広島ホームテレビ","eat"=>"愛媛朝日テレビ","UX"=>"新潟テレビ21","ABC"=>"朝日放送","KHB"=>"東日本放送","KSB"=>"瀬戸内海放送","KAB"=>"熊本朝日放送","QAB"=>"琉球朝日放送","KFB"=>"福島放送","AAB"=>"秋田朝日放送","NCC"=>"長崎文化放送","abn"=>"長野朝日放送","ABA"=>"青森朝日放送","SATV"=>"静岡朝日テレビ","KKB"=>"鹿児島放送","TVQ"=>"TVQ九州放送","TSC"=>"テレビせとうち","TVh"=>"テレビ北海道","TVO"=>"テレビ大阪","TVA"=>"テレビ愛知","TX"=>"テレビ東京","BSフジ"=>"BSフジ","SAY"=>"さくらんぼテレビ","STS"=>"サガテレビ","TOS"=>"テレビ大分","UMK"=>"テレビ宮崎","EBC"=>"テレビ愛媛","tss"=>"テレビ新広島","TKU"=>"テレビ熊本","TNC"=>"テレビ西日本","KTN"=>"テレビ長崎","SUT"=>"テレビ静岡","CX"=>"フジテレビ","OX"=>"仙台放送","UHB"=>"北海道文化放送","BBT"=>"富山テレビ","TSK"=>"山陰中央テレビ","OHK"=>"岡山放送","MIT"=>"岩手めんこいテレビ","NST"=>"新潟総合テレビ","THK"=>"東海テレビ","OTV"=>"沖縄テレビ","ITC"=>"石川テレビ","FTB"=>"福井テレビ","FTV"=>"福島テレビ","AKT"=>"秋田テレビ","NBS"=>"長野放送","KTV"=>"関西テレビ","KSS"=>"高知さんさんテレビ","KTS"=>"鹿児島テレビ","BS日テレ"=>"BS日テレ","TSB"=>"テレビ信州","TVI"=>"テレビ岩手","TeNY"=>"テレビ新潟","KTK"=>"テレビ金沢","CTV"=>"中京テレビ","KNB"=>"北日本放送","RNB"=>"南海放送","JRT"=>"四国放送","MMT"=>"宮城テレビ","KRY"=>"山口放送","YBC"=>"山形放送","YBS"=>"山梨放送","HTV"=>"広島テレビ","NTV"=>"日本テレビ","NKT"=>"日本海テレビ","STV"=>"札幌テレビ","KKT"=>"熊本県民テレビ","FBC"=>"福井放送","FBS"=>"福岡放送","FCT"=>"福島中央テレビ","ABS"=>"秋田放送","RNC"=>"西日本放送","ytv"=>"読売テレビ","NIB"=>"長崎国際テレビ","RAB"=>"青森放送","SDT"=>"静岡第一テレビ","RKC"=>"高知放送","KYT"=>"鹿児島読売テレビ","ETV"=>"NHK Eテレ","GTV"=>"NHK総合","AT-X"=>"AT-X","BS11"=>"BS11","BS12 TwellV"=>"BS12 TwellV","BSアニマックス"=>"BSアニマックス","BS朝日"=>"BS朝日","MX"=>"TOKYO MX","GYT"=>"とちぎテレビ","BBC"=>"びわ湖放送","アニマックス"=>"アニマックス","キッズステーション"=>"キッズステーション","SUN"=>"サンテレビ","WTV"=>"テレビ和歌山","TVS"=>"テレビ埼玉","tvk"=>"テレビ神奈川","ファミリー劇場"=>"ファミリー劇場","MTV"=>"三重テレビ","KBS"=>"京都放送","CTC"=>"千葉テレビ","TVN"=>"奈良テレビ","GBS"=>"岐阜放送","UD"=>"放送大学学園","AFN"=>"米軍放送","AFN"=>"米軍放送","AFN"=>"米軍放送","GTV"=>"群馬テレビ",}
  
  DAYS = Hash[%W(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日).each_with_index.map{|v,i| [v,i]}]
  
  
  def self.channels(key=nil)
    key.nil? ? CHANNELS : CHANNELS[key.to_s]
  end
  
  def self.regions(key=nil)
    key.nil? ? REGIONS : REGIONS[key.to_i]
  end
  
  def self.days(key=nil)
    key.nil? ? DAYS : DAYS[key.to_s]
  end
  
  
  def self.find_by_region(region)
    self.find(:all, :from=>"/api/table/#{region}.xml")
  end
  
  def self.import
    records = self.find_by_region(:ibaraki)
    fetch_airtimes = []
    new_animes = []
    
    records.each do |record|
      channel_name = self.channels(record.station) || record.station
      channel = Channel.where(:name=>channel_name).first
      channel = Channel.create(:name=>channel_name) if channel.blank?
      
      anime = Anime.where(:title=>record.title).first
      if anime.blank? then
        anime = Anime.create(:title=>record.title)
        new_animes << anime
      end
      
      airtime = Airtime.where(:anime_id=>anime.id, :channel_id=>channel.id).first
      airtime = Airtime.new(:anime_id=>anime.id, :channel_id=>channel.id) if airtime.blank?
      
      start_time = lambda{|t| t[0]*60 + t[1]}[record.time.split(/:/).map{|v| v.to_i}]
      
      case record.state.to_s.intern
      when :new then
        start_date = Date.parse(record.next)
        state = Airtime::STATE_NEW
      when :onair then
        start_date = airtime.start_date
        start_date = Date.today if start_date.blank?
        state = Airtime::STATE_ON_AIR
      end
      
      airtime.update_attributes(
        :day=> self.days(record.week),
        :start_time=> start_time,
        :start_date=> start_date,
        :state=> state,
      )
      fetch_airtimes << airtime
      print '.'
    end
    puts
    
    Airtime.update_all(
      "state = #{Airtime::STATE_FINISH}",
      "id NOT IN (#{fetch_airtimes.map{|v| v.id}.join(',')})"
    ) unless fetch_airtimes.blank?
    
    threads = new_animes.uniq.map do |anime|
      puts anime.title
      sleep 0.5
      Thread.new{anime.autoset.save} 
    end
    threads.each{|t| t.join}
  end
end
