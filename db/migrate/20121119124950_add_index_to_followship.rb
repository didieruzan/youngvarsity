class AddIndexToFollowship < ActiveRecord::Migration
  def change
  	add_index :followships, :follower_id
  	add_index :followships, :followed_id
  end
end
