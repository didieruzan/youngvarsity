class AddAvatarTinyUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_tiny_uid, :string
  end
end
