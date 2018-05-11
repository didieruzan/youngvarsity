class UsersController < ApplicationController

  before_filter :authenticate_user! , :except => [:public_profile, :psi_img_med, :qrcode]
  before_filter :checkFB_permissions, :except => [:public_profile, :psi_img_med, :qrcode]


  def index
      redirect_to '/users/login' and return if !current_user.is_active
      @person = @user = current_user
      # @photos = @user.photos(:include => :comments).paginate(:per_page => 26, :page => params[:page])
      @photos ||= @person.photos
      @comment_create = Comment.new
      render "show"
  end

  def show
    redirect_to '/users/login' and return if !current_user.is_active
    @user = current_user
  	@person = User.find_by_guid(params[:id]) || ( not_found and return )
  	# @photos = @user.photos(:include => :comments).paginate(:per_page => 26, :page => params[:page])
    @photos ||= @person.photos
    @comment_create = Comment.new
  end

  def public_profile

    if !params[:nickname].nil?
       @person = User.find_by_nickname(params[:nickname].gsub!(/-/, '.')) || ( not_found and return )
    else
      @person = User.find_by_guid(params[:id]) || ( not_found and return )
    end
     render :layout => 'user_view'
  end

  def edit
    redirect_to '/users/login' and return if !current_user.is_active
    @person = @user = current_user
    render :layout => 'profile'
  end

  def refreshed_edit
    redirect_to '/users/login' and return if !current_user.is_active
    @person = @user = current_user
    @hide_welcome = true
    render :edit, :layout => 'profile'
  end

 def media
    redirect_to '/users/login' and return if !current_user.is_active
    @person = @user = current_user
    @photos ||= @user.photos
    @comment_create = Comment.new
    @media = true
    render :me
  end

  def me
    redirect_to '/users/login' and return if !current_user.is_active
    @person = @user = current_user
    @photos ||= @user.photos
    @comment_create = Comment.new
  end

  def control_panel
    redirect_to '/users/login' and return if !current_user.is_active
    @person = @user = current_user
    render :layout => 'darken'
  end


  def update
  	#user = User.find(params[:id])
  	user = current_user
    if user.qrcode.blank? 
      params[:user][:remote_qrcode_url] = "http://chart.googleapis.com/chart?chs=80x80&chld=|2&cht=qr&chl=http://youngvarsity.com/me/#{user.nickname.gsub!(/\./, '-')}" 
    end

    if !params[:user][:remote_bgimg_url].blank?
      updatingImg = true
    end
      params[:user][:box_text_col] = params[:user][:box_text_col].gsub(/#/, '') if params[:user][:box_text_col]
      if params[:box_bg_color_transparent] == 'on'
        params[:user][:box_bg_color] = ''
      else
        params[:user][:box_bg_color] = params[:user][:box_bg_color].gsub(/#/, '') if params[:user][:box_bg_color]
      end


    respond_to do |format|
      if user.update_attributes(params[:user])

        format.js {}
        format.html {
          if updatingImg
            flash[:notice] = "Image Updated successfully"
            redirect_to "/profile"
          else
            flash[:notice] = "Profile saved successfully"
            redirect_to "/controls"
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit", error: 'Profile could not be saved' }
      end
    end





  end

  def psi_img_med

    user = User.find_by_guid(params[:guid]) || ( not_found and return )
    psi_img = user.psi_image_med || ( not_found and return )

    send_data psi_img.data, :type => 'image/jpeg', :disposition => 'inline'
  end

  def search
    # render json: %w[alan didier carmit joseph]
    render json: current_user.search_friends(params[:name_starts_with])
  end

  def invite
    fb_id = params[:fb_id]
    if !fb_id.nil?
      @newuser = current_user.create_from_facebook(fb_id)
      @newuser.update_attribute(:is_invited, true)
    else
      render json: {  :status => 'error', :message => 'missing param' }
    end
  end

  def stats

    @football_stats = current_user.football_stats
    @basketball_stats = current_user.basketball_stats
    @baseball_stats = current_user.baseball_stats
    @soccer_stats = current_user.soccer_stats

  end


  def post_psi_on_fb
    psi_img = current_user.psi_image_med || ( not_found and return ) # to initiate job

    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    @graph.put_picture("#{@current_user.psi_image_med}", {:message => "Just updated my PSI on Youngvarsity, check it out:\n http://Youngvarsity.com/view/#{current_user.guid}"})
    render :nothing => true
  end

  def crop_psi_bg

    puts "in USER controller > action: crop_psi_bg"
    coords = params[:coords]
    current_user.crop_x = coords['x']
    current_user.crop_y = coords['y']
    current_user.crop_w = coords['w']
    current_user.crop_h = coords['h']
    current_user.crop_iw = coords['iw']
    current_user.crop_ih = coords['ih']

    @error = false
    @error = true if coords.nil?

    current_user.crop_bgimg
    current_user.save!

  end

  def qrcode
    if current_user
     # url = "http://youngvarsity.com/view/d87e350894d0fa6f7af08ffca1b576da" #"http://youngvarsity.com/view/97cec3771f07d8d8ae7b83564562a748"
      url = "#{ENV["WEBSITE_URL"]}view/#{current_user.guid}"
      unit = params[:unit].nil? ? 5 : params[:unit].to_i 
      respond_to do |format|
        format.html
        format.svg  { render :qrcode => url,  :level => :h, :unit => unit, :offset => 10  }
        format.png  { render :qrcode => url,  :level => :l, :unit => unit, :offset => 10 }
      end
    else
      render :nothing => true
    end
  end


  def qrcode_sm
    if current_user
     # url = "http://youngvarsity.com/view/d87e350894d0fa6f7af08ffca1b576da" #"http://youngvarsity.com/view/97cec3771f07d8d8ae7b83564562a748"
      url = "#{ENV["WEBSITE_URL"]}view/#{current_user.guid}"
      respond_to do |format|
        format.html
        format.svg  { render :qrcode => url, :level => :h, :unit => 1, :offset => 1  }
        format.png  { render :qrcode => url, :level => :h, :unit => 1, :offset => 1  }
      end
    else
      render :nothing => true
    end
  end

end