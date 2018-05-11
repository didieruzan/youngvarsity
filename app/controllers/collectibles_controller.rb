class CollectiblesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :checkFB_permissions

  # GET /collectibles
  # GET /collectibles.json
  def index
    @collectibles = current_user.collectibles

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collectibles }
    end
  end

  # GET /collectibles/1
  # GET /collectibles/1.json
  def show
    @collectible = Collectible.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @collectible }
    end
  end

  # GET /collectibles/new
  # GET /collectibles/new.json
  def new
    # @collectible = Collectible.new
    @collectible = current_user.collectibles.build
    respond_to do |format|
      if @collectible.save
        format.html { redirect_to "/collectibles/#{@collectible.id}/edit" }
      else
        format.html # new.html.erb
        format.json { render json: @collectible }
      end
    end

  end

  # GET /collectibles/1/edit
  def edit
    @collectible = Collectible.find(params[:id])
    @collectible.field_pos = current_user.field_pos if @collectible.field_pos.blank?
    @collectible.team_name = current_user.team_name if @collectible.team_name.blank?
    @collectible.jersey_num = current_user.jersey_num if @collectible.jersey_num.blank?
    @collectible.weight = current_user.weight if !current_user.weight.blank?

    if !current_user.height.blank?
      height = current_user.height.split('-')
      @collectible.height_ft = height[0]
      @collectible.height_in = height[1]
    end


  end

  # POST /collectibles
  # POST /collectibles.json
  def create
    @collectible = Collectible.create(params[:collectible])
  end


  # PUT /collectibles/1
  # PUT /collectibles/1.json
  def update
    @collectible = Collectible.find(params[:id])
    if (!params[:collectible][:shipping_address].blank? || !params[:collectible][:phone].blank?)
      if (!@collectible.srcphoto.blank? && !@collectible.jersey_num.blank?)
        current_print_orders = current_user.collectibles.where(to_print: true)

        if current_print_orders.count < 1 #current_user.open_print_order.count < 1
          params[:collectible][:to_print] = 1
          UserMailer.card_print_order( current_user, 'order' ).deliver
        end
      end
    end
    respond_to do |format|
      if @collectible.update_attributes(params[:collectible])
         @uptated_image = @collectible.srcphoto_url(:medium)

         current_user.update_attribute(:height, "#{params[:collectible][:height_ft]}-#{params[:collectible][:height_in]}") if (!params[:collectible][:height_in].nil? && !params[:collectible][:height_in].nil?)
         current_user.update_attribute(:weight, params[:collectible][:weight]) if (!params[:collectible][:weight].nil?)

         current_user.update_attribute(:remote_qrcode_url, "http://chart.googleapis.com/chart?chs=80x80&chld=|2&cht=qr&chl=http://youngvarsity.com/me/#{current_user.nickname.gsub!(/\./, '-')}" ) if current_user.qrcode.blank?



         format.js {}
         format.html {
          if params[:reload] == 'reload_edit'
            render action: "edit"
          else
            redirect_to collectibles_url, notice: 'Collectible was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collectible.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collectibles/1
  # DELETE /collectibles/1.json
  def destroy
    @collectible = Collectible.find(params[:id])
    @collectible.destroy

    respond_to do |format|
      format.html { redirect_to collectibles_url }
      format.json { head :no_content }
    end
  end




  def crop_photo

    coords = params[:coords]
    @collectible = Collectible.find(coords['cid'])

    @collectible.crop_x = coords['x']
    @collectible.crop_y = coords['y']
    @collectible.crop_w = coords['w']
    @collectible.crop_h = coords['h']
    @collectible.crop_iw = coords['iw']
    @collectible.crop_ih = coords['ih']

    @error = false
    @error = true if coords.nil?

    @collectible.crop_card_img
    @collectible.save!

    render :update

  end

  def get_stat_table
    @chosen_stats = params[:stats] if (!params[:stats].nil? && params[:stats] != "0")
  end

  def order_print
    @collectible = Collectible.find_by_id(params[:id]) || ( not_found and return )
    @collectible.weight = current_user.weight if !current_user.weight.blank?
    if !current_user.height.blank?
      height = current_user.height.split('-')
      @collectible.height_ft = height[0]
      @collectible.height_in = height[1]
    end

  end

  def cancel_print
    @collectible = Collectible.find_by_id(params[:id]) || ( not_found and return )
    @collectible.to_print = false
    @collectible.save!
    UserMailer.card_print_order( current_user, 'cancel' ).deliver
    respond_to do |format|
      format.html { redirect_to collectibles_url, notice: 'Print order canceled' }
      format.json { head :no_content }
    end
  end

end
