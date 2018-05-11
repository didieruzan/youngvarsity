class FootballStatsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :checkFB_permissions

  # GET /football_stats
  # GET /football_stats.json
  def index
    @football_stats = current_user.football_stats
    @model_labels = FootballStat.labels
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @football_stats }
    end
  end

  # GET /football_stats/1
  # GET /football_stats/1.json
  def show
    @football_stat = current_user.football_stats.find(params[:id]) #FootballStat.find(params[:id])
    @model_labels = FootballStat.labels
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @football_stat }
    end
  end

  # GET /football_stats/new
  # GET /football_stats/new.json
  def new
    @football_stat = FootballStat.new
    @model_labels = FootballStat.labels
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @football_stat }
    end
  end

  # GET /football_stats/1/edit
  def edit
    @football_stat = FootballStat.find(params[:id])
    @model_labels = FootballStat.labels
  end

  # POST /football_stats
  # POST /football_stats.json
  def create

    params['football_stat']['user_id'] = current_user.id
    @football_stat = FootballStat.new(params[:football_stat])
    @model_labels = FootballStat.labels
    respond_to do |format|
      if @football_stat.save
        format.html { redirect_to "/stats", notice: 'Football stats successfully created.' }
        format.json { render json: @football_stat, status: :created, location: @football_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @football_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /football_stats/1
  # PUT /football_stats/1.json
  def update
    @football_stat = FootballStat.find(params[:id])
    @model_labels = FootballStat.labels
    respond_to do |format|
      if @football_stat.update_attributes(params[:football_stat])
        format.html { redirect_to "/stats", notice: 'Football stats successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @football_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /football_stats/1
  # DELETE /football_stats/1.json
  def destroy
    @football_stat = FootballStat.find(params[:id])
    @football_stat.destroy

    respond_to do |format|
      format.html { redirect_to "/stats", notice: 'Football stats deleted.' }
      format.json { head :no_content }
    end
  end
end
