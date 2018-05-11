class AddTeamurlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :teamurl, :string
  end
end
