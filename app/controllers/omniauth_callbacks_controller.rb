class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
    #raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
		user = User.from_omniauth(auth)

    user.country = request.location.country

    user.remember_me = true
    	# if user.persisted? # means the user was found in the db, hence returning user
          if user.is_active
            sign_in user
            if !user.is_profile_incomplete?
              redirect_to '/me' and return
            else
              redirect_to '/controls' and return
            end
          elsif user.is_invited
            user.is_active = true
            user.email = auth.info.email
            user.save
            sign_in user
            if !user.is_profile_incomplete?
              redirect_to '/me' and return
            else
              redirect_to '/controls' and return
            end
          elsif !session[:fb_ad].nil?
            user.is_active = true
            user.email = auth.info.email
            user.save
            sign_in user
            if !user.is_profile_incomplete?
              redirect_to '/me' and return
            else
              redirect_to '/controls' and return
            end
          elsif !session[:invite_token].nil?
            i = Invitation.find_by_token(session[:invite_token])
            if !i.nil? && i.is_active
              user.is_active = true
              user.save
              i.is_active = false
              i.recipient = user.id
              i.date_used = Time.now
              i.save
              sign_in user
              if !user.is_profile_incomplete?
                redirect_to '/me' and return
              else
                redirect_to '/controls' and return
              end
            end
            flash.notice = ""
            flash.alert = "Invalid Invitation token!"
          else
            if ENV["INVITE_ONLY"] != "TRUE"
              user.is_active = true
              user.save
            else
              flash.notice = "Invite request received!"
            end
          end
            sign_in_and_redirect user
        end
    	# else
      #  		session["devise.user_attributes"] = user.attributes
      #     redirect_to '/terms'
      #     #redirect_to new_user_registration_url
    	# end


end
