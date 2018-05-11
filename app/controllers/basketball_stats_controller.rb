class BasketballStatsController < ApplicationController
  # GET /basketball_stats
  # GET /basketball_stats.json
  def index
    @basketball_stats = BasketballStat.all
    @model_labels = BasketballStat.labels
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @basketball_stats }
    end
  end

  # GET /basketball_stats/1
  # GET /basketball_stats/1.json
  def show
    @basketball_stat = BasketballStat.find(params[:id])
    @model_labels = BasketballStat.labels
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @basketball_stat }
    end
  end

  # GET /basketball_stats/new
  # GET /basketball_stats/new.json
  def new
    @basketball_stat = BasketballStat.new
    @model_labels = BasketballStat.labels
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @basketball_stat }
    end
  end

  # GET /basketball_stats/1/edit
  def edit
    @basketball_stat = BasketballStat.find(params[:id])
    @model_labels = BasketballStat.labels
  end

  # POST /basketball_stats
  # POST /basketball_stats.json
  def create
    params['basketball_stat']['user_id'] = current_user.id
    @basketball_stat = BasketballStat.new(params[:basketball_stat])
    @model_labels = BasketballStat.labels
    respond_to do |format|
      if @basketball_stat.save
        format.html { redirect_to "/stats", notice: 'Basketball stats successfully created.' }
        format.json { render json: @basketball_stat, status: :created, location: @basketball_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @basketball_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /basketball_stats/1
  # PUT /basketball_stats/1.json
  def update
    @basketball_stat = BasketballStat.find(params[:id])
    @model_labels = BasketballStat.labels
    respond_to do |format|
      if @basketball_stat.update_attributes(params[:basketball_stat])
        format.html { redirect_to "/stats", notice: 'Basketball stats successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @basketball_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /basketball_stats/1
  # DELETE /basketball_stats/1.json
  def destroy
    @basketball_stat = BasketballStat.find(params[:id])
    @basketball_stat.destroy

    respond_to do |format|
      format.html { redirect_to "/stats", notice: 'Basketball stats deleted.' }
      format.json { head :no_content }
    end
  end
end
