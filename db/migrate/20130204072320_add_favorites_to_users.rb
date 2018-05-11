class AddFavoritesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_athletes, :text
    add_column :users, :favorite_teams, :text
  end
end
