class AddUserIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :user_id, :integer
    add_column :photos, :photo_image_uid,  :string
  end
end
