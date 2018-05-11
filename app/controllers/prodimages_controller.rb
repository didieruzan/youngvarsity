class ProdimagesController < ApplicationController
  before_filter :authenticate_user!


  def create
    unless params[:prodimage][:image].nil? || params[:product_id].nil?
      product = Product.find_by_id(params[:product_id])
      if !product.nil?
        @image = product.prodimages.build(:image => params[:prodimage][:image])
        @image.save
      end
    end

  end

  def destroy
    if !params["ppid"].nil?
      p = Prodimage.find_by_id(params["ppid"])
      puts p.id
      if p
        p.destroy
      end
    end
  end


  # def show
  #   unless  params["piid"].nil?
  #     @image = Prodimage.find_by_id(params["piid"])
  #   end
  # end


end
