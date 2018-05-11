class PageController < ApplicationController

	def fbchannel
		cache_expire = 1.year
		response.headers["Pragma"] = "public"
		response.headers["Cache-Control"] = "max-age=#{cache_expire.to_i}"
		response.headers["Expires"] = (Time.now + cache_expire).strftime("%d %m %Y %H:%I:%S %Z")
		render :layout => false, :inline => "<script src='//connect.facebook.net/en_US/all.js'></script>"
	end



end