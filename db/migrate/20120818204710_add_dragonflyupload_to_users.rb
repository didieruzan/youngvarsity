class AddDragonflyuploadToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cover_image_uid, :string
    add_column :users, :cover_image_name, :string
  end
end
