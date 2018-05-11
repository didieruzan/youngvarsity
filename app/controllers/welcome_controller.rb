class WelcomeController < ApplicationController

  def index

    if params["invite"] #if the user is coming with a invitation, check if it is valid
       @inviteToken = checkInvite params["invite"]
    end

  	if user_signed_in?
  		if @current_user.is_active
          redirect_to '/me' and return
      elsif !@inviteToken.nil?
        session[:invite_token] = @inviteToken
        render 'welcome_invited', :layout => 'blank_grass'
      elsif !params["request_ids"].nil?
        render :out_of_iframe
      else
        render 'pending', :layout => 'blank_grass'
      end
    else
      redirect_to '/users/login' and return
      #if the user is comming from an ad, they direct him to the welcome grid page
    	# if params["fb_source"] == "ad"
    	# 	render :layout => 'welcomeA'
     #  elsif !@inviteToken.nil?
      if !@inviteToken.nil?
        session[:invite_token] = @inviteToken
        render 'welcome_invited', :layout => 'blank_grass'
      elsif !params["request_ids"].nil?
        render :out_of_iframe
        # render text: "<html><body><script type='text/javascript' charset='utf-8'>window.parent.document.location.href = '#{ENV["WEBSITE_URL"]}users/auth/facebook';</script></body></html>", content_type: :html
      else
    		redirect_to '/users/login' and return
    	end
  	end
  end

  def test
    @inviteToken = 'stam'
  #  render 'invited', :layout => 'welcomeA'
  # render 'welcome_invited', :layout => 'blank_grass'
   render 'app', :layout => 'blank_fbpage'
  end

  def app
    redirect_to '/users/auth/facebook' and return if ENV["INVITE_ONLY"] != "TRUE"
    @inviteToken = 'stam'
    session[:fb_ad] = true if params["fb_source"] == "ad"
    render 'invited', :layout => 'welcomeA'
  end

  def app_old
    @inviteToken = 'stam'
    session[:fb_ad] = true if params["fb_source"] == "ad"
    render :layout => 'blank_fbpage'
  end

  def likegate_baseball

    @liked = false
    if !params['signed_request'].nil?
      p = params['signed_request'].split('.')[1]
      puts p
      json = Base64.decode64(p + "=" * (4 - p.size % 4))
      data = ActiveSupport::JSON.decode(json)
      @liked = data["page"]["liked"]
      puts @liked
    end
    render :layout => false
  end

  def likegate_football

    @liked = false
    if !params['signed_request'].nil?
      p = params['signed_request'].split('.')[1]
      puts p
      json = Base64.decode64(p + "=" * (4 - p.size % 4))
      data = ActiveSupport::JSON.decode(json)
      @liked = data["page"]["liked"]
      puts @liked
    end
    render :layout => false
  end

  def save_invite_request
  	if  params["lead_email"]
 		   res = Invitereq.find_by_email( params["lead_email"] )
 		   if (res.nil?)
 			    Invitereq.create(email: params["lead_email"])
          UserMailer.incoming_invite_req( params["lead_email"] ).deliver
          UserMailer.incoming_invitation( params["lead_email"] ).deliver
          render json: {  :status => 'ok' }
        else
          render json: {  :status => 'double' }
		   end
	  end

  end

  def checkInvite token
    i = Invitation.find_by_token(token)
    if !i.nil? && i.is_active
      session[:invite_token] = i.token
    else
      nil
    end
  end


end
