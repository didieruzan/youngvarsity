class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qrcode, :string
    add_column :users, :jerseynum, :integer
  end
end
