class AddMemoToAnimes < ActiveRecord::Migration
  def change
    add_column :animes, :memo, :text
  end
end
