# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130422134107) do

  create_table "airtimes", :force => true do |t|
    t.integer "anime_id"
    t.integer "channel_id"
    t.integer "day"
    t.integer "start_time"
    t.date    "start_date"
    t.integer "enable",     :default => 1
  end

  add_index "airtimes", ["anime_id", "channel_id", "day", "start_time"], :name => "index_airtimes_on_anime_id_and_channel_id_and_day_and_start_time", :unique => true
  add_index "airtimes", ["anime_id"], :name => "index_airtimes_on_anime_id"
  add_index "airtimes", ["channel_id"], :name => "index_airtimes_on_channel_id"
  add_index "airtimes", ["day"], :name => "index_airtimes_on_day"
  add_index "airtimes", ["start_date"], :name => "index_airtimes_on_start_date"
  add_index "airtimes", ["start_time"], :name => "index_airtimes_on_start_time"

  create_table "animes", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "rating",      :default => 0
    t.string  "site_url"
    t.string  "image_url"
    t.string  "video_url"
    t.integer "enable",      :default => 1
    t.text    "memo"
  end

  add_index "animes", ["rating"], :name => "index_animes_on_rating"
  add_index "animes", ["title"], :name => "index_animes_on_title", :unique => true

  create_table "channels", :force => true do |t|
    t.string  "name"
    t.integer "no"
    t.integer "enable", :default => 1
  end

  add_index "channels", ["name"], :name => "index_channels_on_name", :unique => true

  create_table "system_settings", :force => true do |t|
    t.integer "region"
    t.integer "parallel_recording_size"
  end

end
