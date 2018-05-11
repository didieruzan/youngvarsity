class BaseballStatsController < ApplicationController
  # GET /baseball_stats
  # GET /baseball_stats.json
  def index
    @baseball_stats = BaseballStat.all
    @model_labels = BaseballStat.labels
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @baseball_stats }
    end
  end

  # GET /baseball_stats/1
  # GET /baseball_stats/1.json
  def show
    @baseball_stat = BaseballStat.find(params[:id])
    @model_labels = BaseballStat.labels
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @baseball_stat }
    end
  end

  # GET /baseball_stats/new
  # GET /baseball_stats/new.json
  def new
    @baseball_stat = BaseballStat.new
    @model_labels = BaseballStat.labels
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @baseball_stat }
    end
  end

  # GET /baseball_stats/1/edit
  def edit
    @baseball_stat = BaseballStat.find(params[:id])
    @model_labels = BaseballStat.labels
  end

  # POST /baseball_stats
  # POST /baseball_stats.json
  def create
    params['baseball_stat']['user_id'] = current_user.id
    @baseball_stat = BaseballStat.new(params[:baseball_stat])
    @model_labels = BaseballStat.labels
    respond_to do |format|
      if @baseball_stat.save
        format.html { redirect_to "/stats", notice: 'Baseball stats successfully created.' }
        format.json { render json: @baseball_stat, status: :created, location: @baseball_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @baseball_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /baseball_stats/1
  # PUT /baseball_stats/1.json
  def update
    @baseball_stat = BaseballStat.find(params[:id])
    @model_labels = BaseballStat.labels
    respond_to do |format|
      if @baseball_stat.update_attributes(params[:baseball_stat])
        format.html { redirect_to "/stats", notice: 'Baseball stats successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @baseball_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baseball_stats/1
  # DELETE /baseball_stats/1.json
  def destroy
    @baseball_stat = BaseballStat.find(params[:id])
    @baseball_stat.destroy

    respond_to do |format|
      format.html { redirect_to "/stats", notice: 'Baseball stats deleted.' }
      format.json { head :no_content }
    end
  end
end
