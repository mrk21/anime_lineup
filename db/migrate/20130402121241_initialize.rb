class Initialize < ActiveRecord::Migration
  def change
    create_table :animes do |t|
      t.column :title       , :string, :nil=>false
      t.column :description , :text
      t.column :rating      , :integer
      t.column :site_url    , :string
      t.column :image_url   , :string
      t.column :video_url   , :string
      t.column :enable      , :integer, :default=>1
    end
    add_index :animes, :title, :unique=>true
    add_index :animes, :rating
    
    create_table :channels do |t|
      t.column :name  , :string, :nil=>false
      t.column :no    , :integer
      t.column :enable, :integer, :default=>1
    end
    add_index :channels, :name, :unique=>true
    
    create_table :airtimes do |t|
      t.column :anime_id  , :integer, :nil=>false
      t.column :channel_id, :integer, :nil=>false
      t.column :day       , :integer, :nil=>false
      t.column :start_time, :integer, :nil=>false
      t.column :start_date, :date
      t.column :state     , :integer, :default=>0
      t.column :enable    , :integer, :default=>1
    end
    add_index :airtimes, [:anime_id, :channel_id, :day, :start_time], :unique=>true
    add_index :airtimes, :anime_id
    add_index :airtimes, :channel_id
    add_index :airtimes, :day
    add_index :airtimes, :start_time
    add_index :airtimes, :start_date
    
    create_table :system_settings do |t|
      t.column :region, :integer
      t.column :parallel_recording_size, :integer
    end
  end
end
