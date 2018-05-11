class CpadminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :onlyAdmin
  before_filter :checkFB_permissions

  def index
    render :layout => 'admin'
  end
end
