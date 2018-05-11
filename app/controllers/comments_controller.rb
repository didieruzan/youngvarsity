class CommentsController < ApplicationController
	before_filter :authenticate_user!
  before_filter :checkFB_permissions

	def create
	    @comment = Comment.new(params[:comment])
	    # double check if use is authorized to leave a comment for that item
	    @comment.user = current_user
	    @comment.save
	end


  def destroy
    unless  params["guid"].nil?
      c = Comment.find_by_guid(params["guid"])
      if c
        if (current_user.id === c.user_id || current_user.id === c.photo.user_id)
          c.destroy
          @c_id = "comment_#{c.guid}"
        end
      end
    end
  end

end
