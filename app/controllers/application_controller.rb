class ApplicationController < ActionController::Base
  protect_from_forgery

  layout Proc.new { |controller| controller.devise_controller? ? 'blank_grass' : 'application' }

  def onlyAdmin
    if current_user.nil? || !current_user.is_admin
      return redirect_to '/'
    end
  end



  def checkFB_permissions

    # if !current_user.nil?
    #   @graph = Koala::Facebook::API.new(current_user.oauth_token)
    #   user_permissions = @graph.get_connections('me','permissions')
    #   required_permissions = ENV["FB_SCOPE"].split(',')
    #   @missing_permission = []

    #   required_permissions.each do |permission|
    #     @missing_permission << permission if ( user_permissions[0][permission].nil? || user_permissions[0][permission].to_i != 1 )
    #   end

    # end

  end

  def not_found

    respond_to do |format|
      format.html { render :layout => 'blank_grass',:file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def test_exception_notifier
    raise 'This is a test. This is only a test.'
  end

end
