class AddCommentToInvite < ActiveRecord::Migration
  def up
    	add_column :invitations, :comments, :string
	end
end
