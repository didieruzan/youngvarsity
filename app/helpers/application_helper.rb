module ApplicationHelper

  def user_log_identity
    if user_signed_in?
      if !current_user.nickname.blank?
        current_user.nickname
      else
        current_user.guid
      end
    else
      return false
    end
  end

	def	userBgFull
		# if current_user
		# 	user = current_user
		# else
			user = @person
      user = current_user if @person.nil?
		# end
    @user_bg_full ||= user.get_bg_full
	end

	def	userBgThumb
		if current_user
			user = current_user
		else
			user = @person
		end
    @user_bg_thumb ||= user.get_bg_thumb

	end

  def userPsiFramedImage
    if current_user
      user = current_user
    else
      user = @person
    end
    @user_psi_image_med ||= user.psi_image_med

  end




	def userBgAlign
		if current_user
			user = current_user
		else
			user = @person
		end
		@user_bg_align ||= user.align_landscape
	end

	def userBgAlignPortrait
		if current_user
			user = current_user
		else
			user = @person
		end
		@user_bg_portrait ||= user.align_portrait
	end

  def person
    if !@person.nil?
      @person
    elsif user_signed_in?
        current_user
    end
  end

  def userFootballStats
    user = @person
    user = current_user if @person.nil?
    @footballStats ||= user.cached_football_stats
  end

  def statsHeadersFootball
    FootballStat.labels
  end

  def userSoccerStats
    user = @person
    user = current_user if @person.nil?
    @soccerStats ||= user.cached_soccer_stats
  end

  def statsHeadersSoccer
    SoccerStat.labels
  end

  def userBaseballStats
    user = @person
    user = current_user if @person.nil?
    @baseballStats ||= user.cached_baseball_stats
  end

  def statsHeadersBaseball
    BaseballStat.labels
  end

  def userBasketballStats
    user = @person
    user = current_user if @person.nil?
    @basketballStats ||= user.cached_basketball_stats
  end

  def statsHeadersBasketball
    BasketballStat.labels
  end

  def statList
    user = @person
    user = current_user if @person.nil?
    stats = {}

    if !user.cached_baseball_stats.nil?
      stats[:baseball] = { :stat_id => user.cached_baseball_stats.id, :updated => "updated #{time_ago_in_words(user.cached_baseball_stats.updated_at)} ago" }
    end

    if !user.cached_football_stats.nil?
      stats[:football] = { :stat_id => user.cached_football_stats.id, :updated => "updated #{time_ago_in_words(user.cached_football_stats.updated_at)} ago" }
    end

    if !user.cached_soccer_stats.nil?
      stats[:soccer] = { :stat_id => user.cached_soccer_stats.id, :updated => "updated #{time_ago_in_words(user.cached_soccer_stats.updated_at)} ago" }
    end

    if !user.cached_basketball_stats.nil?
      stats[:basketball] = { :stat_id => user.cached_basketball_stats.id, :updated => "updated #{time_ago_in_words(user.cached_basketball_stats.updated_at)} ago" }
    end

    return stats
  end

  def featuredStatsFootball
    stats = {:hits => { :accronym => "HIT", :desc => "Hits" },
             :batting_average => { :accronym => "BA", :desc => "Batting Average" },
             :at_bat => { :accronym => "AB", :desc => "At bat" } }
  end

  def featuredStatsBaseball
    stats =  [ { :dbfield => :hits, :accronym => "HIT", :desc => "Hits" },
              { :dbfield => :batting_average, :accronym => "BA", :desc => "Batting Average" },
              { :dbfield => :at_bat, :accronym => "AB", :desc => "At bat" } ]
  end

  def featuredStatsBasketball
    stats = { :hits => "HIT", :batting_average => "BA", :at_bat => "AB" }
  end

  def featuredStatsSoccer
    stats = { :hits => "HIT", :batting_average => "BA", :at_bat => "AB" }
  end

  def getSpecificStats identifier
    r = identifier.split("-")
    return if r.nil?
    
    sport = r[0]
    stat_id = r[1]
    stat = {}

    case sport
      when 'football'
        stat[:icon] = "25fe"
        stat[:data] = current_user.football_stats.find_by_id stat_id
        stat[:labels] = statsHeadersFootball
      when 'baseball'
        stat[:icon] = "e000"
        stat[:data] = current_user.baseball_stats.find_by_id stat_id
        stat[:labels] = statsHeadersBaseball
      when 'basketball'
        stat[:icon] = "45"
        stat[:data] = current_user.basketball_stats.find_by_id stat_id
        stat[:labels] = statsHeadersBasketball
      when 'soccer'
        stat[:icon] = "46"
        stat[:data] = current_user.soccer_stats.find_by_id stat_id
        stat[:labels] = statsHeadersSoccer
     end 

return stat

  end

end
