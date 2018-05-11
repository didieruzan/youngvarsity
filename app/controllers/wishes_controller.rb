class WishesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :checkFB_permissions

  def create
    json = { :status => 'error'}
    if params[:token] != current_user.guid
      json = { :status => 'Error - Invalid permission'}
      render json: json and return
    end

    prod = Product.find_by_id(params[:prodid])
    unless prod.nil?
      current_user.add_wish!(prod.id) if !prod.nil?
      json = {
              :action => "wishadded",
              :prodid => prod.id,
              :status => "success"
              }
    end
    render json: json

  end

  def destroy
    json = { :status => 'error'}
    if params[:token] != current_user.guid
      json = { :status => 'Error - Invalid permission'}
      render json: json and return
    end

    unless params[:prodid].nil?
      current_user.rem_wish!(params[:prodid])
       json = {
              :action => "wishremoved",
              :status => "success"
              }
    end
    render json: json
  end

end