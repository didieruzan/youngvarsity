class FriendshipsController < ApplicationController
	before_filter :authenticate_user!
  before_filter :checkFB_permissions


  def list
    @teammates = current_user.friends
  end


	def create
    user = User.find_by_guid(params[:fid])
    if user.nil?
      flash[:error] = "Error while adding Teammate"
      redirect_to(:back)
    end
		@friendship = current_user.friendships.build(:friend_id => user.id)
		if @friendship.save
			flash[:notice] = "Teammate added"
		else
			flash[:error] = "Error while adding Teammate"
		end
		redirect_to(:back)
	end

	def unfriend
    user = User.find_by_guid(params[:fid])
    if !user.nil?
			current_user.unfriend!(user.id)
			flash[:notice] = "Teammate removed"
		end
		redirect_to(:back)
	end

  def friend_by_facebook_id
    fb_id = params[:fb_id]
    if !fb_id.nil?
      @newuser = User.find_by_facebook_id(fb_id)
      @newuser = current_user.create_from_facebook(fb_id) if @newuser.nil?
      @newuser.update_attribute(:is_invited, true)
      friendship = current_user.friendships.build(:friend_id => @newuser.id)
      if friendship.save
        flash[:notice] = "Teammate added"
      else
        flash[:error] = "Error while adding Teammate"
      end
      redirect_to(:back)
    else
      render json: {  :status => 'error', :message => 'missing param' }
    end
  end

end