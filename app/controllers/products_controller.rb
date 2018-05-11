class ProductsController < ApplicationController
  before_filter :authenticate_user! #, :except => [:public_profile]
  before_filter :onlyAdmin , :except => [:gridview, :wishlist, :itemview]
  before_filter :checkFB_permissions

  # GET /products
  # GET /products.json
  layout 'admin', :except => [:gridview, :wishlist, :itemview]

  def index
    if params[:category]
      @products = Product.tagged_with(params[:category], :match_all => true)
    else
      @products = Product.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @bg = "opaque"

    respond_to do |format|
      format.html { render action: "itemview"} # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit

    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def gridview
    require 'will_paginate/array'
    if params[:guid]
      @token = params[:guid]
      @person = User.find_by_guid(@token)
    end
    @products = {}
    if params[:category]
      category = Category.find_by_id(params[:category])
      category = Category.find_all_by_id(category.child_ids) if category.is_root?
    end

    if !category.nil? && params[:prange].nil?
      if category.kind_of?(Array) && category.count > 1
        @products = category.map { |c| c.products.where(is_active:true) }.flatten
      else
        @products = category.products.where(is_active:true)
      end
    elsif !params[:prange].nil?

      case params[:prange]
      when 'less20'
        @products = if category.nil? then Product.price_less_than(21)
                    else
                      if category.kind_of?(Array)
                        category.map { |c| c.products.where(is_active:true).price_less_than(21) }.flatten
                      else
                        category.products.price_less_than(21)
                      end
                    end
      when '20-50'
        @products = if category.nil? then Product.price_between(19, 51)
                    else
                      if category.kind_of?(Array)
                        category.map { |c| c.products.where(is_active:true).price_between(19, 51) }.flatten
                      else
                        category.products.price_between(19, 51)
                      end
                    end
      when '50-100'
        @products = if category.nil? then Product.price_between(49, 101)
                    else
                      if category.kind_of?(Array)
                        category.map { |c| c.products.where(is_active:true).price_between(49, 101) }.flatten
                      else
                        category.products.price_between(49, 101)
                      end
                    end
      when '100above'
        @products = if category.nil? then Product.price_more_than(99)
                    else
                      if category.kind_of?(Array)
                        category.map { |c| c.products.where(is_active:true).price_more_than(99) }.flatten
                      else
                        category.products.price_more_than(99)
                      end
                    end
      else
        @products = if category.nil? then Product.where(is_active:true)
                    else
                      if category.kind_of?(Array)
                        category.map { |c| c.products.where(is_active:true) }.flatten
                      else
                        category.products.where(is_active:true)
                      end
                    end
      end
    else
      @products = Product.where(is_active:true)
    end
    if @products.count > 6
      @paginate = true
    else
      @paginate = false
    end

    @products = @products.paginate(:page => params[:page], :per_page => 6)
  end

  def wishlist
    if params[:guid]
      @token = params[:guid]
      @person = User.find_by_guid(@token)
      @products = @person.wishes
    else
      @products = current_user.wishes
    end
    if @products.count > 6
      @paginate = true
    else
      @paginate = false
    end
    @products = @products.page(params[:page]).per_page(6)
    render "gridview"
  end

  def itemview
    if params[:token]
      @token = params[:token]
      @person = User.find_by_guid(@token)
    end
    @bg = "opaque"
    @product = Product.find(params[:id])

  end




end
