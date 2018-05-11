class AddIndexToFriendships < ActiveRecord::Migration
  def change
  	add_index :friendships, :friend_id
  	add_index :friendships, :user_id
  end
end
