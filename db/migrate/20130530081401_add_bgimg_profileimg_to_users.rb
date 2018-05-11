class AddBgimgProfileimgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bgimg, :string
    add_column :users, :profileimg, :string
  end
end
