class ModifyTables < ActiveRecord::Migration
  def up
    change_column :animes, :rating, :integer, :default=>0
    change_column :airtimes, :start_date, :date, :nil=>false
    remove_column :airtimes, :state
  end
  
  def down
    change_column :animes, :rating, :integer
    change_column :airtimes, :start_date, :date
    add_column :airtimes, :state, :integer, :default=>0
  end
end
