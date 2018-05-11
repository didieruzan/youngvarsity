class AddMorefieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :box_bg_color, :string
    add_column :users, :theme, :string
  end
end
