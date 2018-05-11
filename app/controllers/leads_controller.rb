class LeadsController < ApplicationController
 before_filter :onlyAdmin
 before_filter :authenticate_user! #, :except => [:public_profile]
 before_filter :checkFB_permissions

 def index
 	if !current_user.is_admin
 		return redirect_to '/'
 	end
 	@leadCount = Lead.count
 end

 def check_lead
 	if  params["lead_url"]
 		res = Lead.find_by_url( params["lead_url"] )
 		if (res.nil?)
			render json: {  :status => 'AVAILABLE' } and return
 		else
			render json: {  :status => 'USED' } and return
 		end
 	end

	render json: {  :status => 'ERROR' }
 end

 def save_lead
	if  params["lead_url"]
 		res = Lead.find_by_url( params["lead_url"] )
 		if (res.nil?)
 			Lead.create(url: params["lead_url"])
			render json: {  :status => 'SAVED', :count => Lead.count } and return
		end
	 end

		render json: {  :status => 'ERROR' }
 end

end
