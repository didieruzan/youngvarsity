class AddUniqnessToFollowships < ActiveRecord::Migration
  def change
  	add_index :followships, [:follower_id, :followed_id], unique: true
  end
end
