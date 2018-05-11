class SoccerStatsController < ApplicationController
  # GET /soccer_stats
  # GET /soccer_stats.json
  def index
    @soccer_stats = SoccerStat.all
    @model_labels = SoccerStat.labels
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @soccer_stats }
    end
  end

  # GET /soccer_stats/1
  # GET /soccer_stats/1.json
  def show
    @soccer_stat = SoccerStat.find(params[:id])
    @model_labels = SoccerStat.labels
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @soccer_stat }
    end
  end

  # GET /soccer_stats/new
  # GET /soccer_stats/new.json
  def new

    @soccer_stat = SoccerStat.new
    @model_labels = SoccerStat.labels
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @soccer_stat }
    end
  end

  # GET /soccer_stats/1/edit
  def edit
    @soccer_stat = SoccerStat.find(params[:id])
    @model_labels = SoccerStat.labels
  end

  # POST /soccer_stats
  # POST /soccer_stats.json
  def create
    params['soccer_stat']['user_id'] = current_user.id
    @soccer_stat = SoccerStat.new(params[:soccer_stat])
    @model_labels = SoccerStat.labels
    respond_to do |format|
      if @soccer_stat.save
        format.html { redirect_to "/stats", notice: 'Soccer stats successfully created.' }
        format.json { render json: @soccer_stat, status: :created, location: @soccer_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @soccer_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /soccer_stats/1
  # PUT /soccer_stats/1.json
  def update
    @soccer_stat = SoccerStat.find(params[:id])
    @model_labels = SoccerStat.labels
    respond_to do |format|
      if @soccer_stat.update_attributes(params[:soccer_stat])
        format.html { redirect_to "/stats", notice: 'Soccer stats successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @soccer_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soccer_stats/1
  # DELETE /soccer_stats/1.json
  def destroy
    @soccer_stat = SoccerStat.find(params[:id])
    @soccer_stat.destroy

    respond_to do |format|
      format.html { redirect_to "/stats", notice: 'Soccer stats deleted.' }
      format.json { head :no_content }
    end
  end
end
