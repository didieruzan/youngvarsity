class FollowshipsController < ApplicationController
	before_filter :authenticate_user!
  before_filter :checkFB_permissions

	def create
		# raise params.inspect
		user = User.find(params[:followship][:followed_id])
		current_user.follow!(user)
		flash[:notice] = "You're now following #{user.firstname}"
		redirect_to(:back)
	end

	def destroy
		# raise params.inspect
		user = Followship.find(params[:id]).followed
		current_user.unfollow!(user)
		flash[:notice] = "You're not following #{user.firstname} anymore"
		redirect_to(:back)
	end

end