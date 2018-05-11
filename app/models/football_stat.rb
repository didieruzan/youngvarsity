# == Schema Information
#
# Table name: football_stats
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  user_id                :integer
#  is_active              :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  number_of_games_played :integer
#  pass_attempts          :integer
#  pass_completions       :integer
#  passing_yards          :integer
#  pass_touchdowns        :integer
#  pass_interceptions     :integer
#  passer_rating          :integer
#  attempts_carries       :integer
#  rush_yards             :integer
#  rush_yards_att         :integer
#  rush_longest           :integer
#  rush_td                :integer
#  received               :integer
#  receiv_yards           :integer
#  receiv_avg             :integer
#  receiv_long            :integer
#  receiv_touchdowns      :integer
#  kick_xpm               :integer
#  kick_xpa               :integer
#  kick_xpp               :integer
#  kick_fgm               :integer
#  kick_fga               :integer
#  kick_fgp               :integer
#  kick_longest           :integer
#  kick_op                :integer
#  defense_tackles_solo   :integer
#  defense_tackles_assist :integer
#  defense_sacks          :integer
#  defense_fumbles        :integer
#  defense_interceptions  :integer
#  defense_yards          :integer
#  defense_longest        :integer
#  defense_td             :integer
#

class FootballStat < ActiveRecord::Base

  attr_accessible :is_active, :title, :user_id, :number_of_games_played, :pass_attempts, :pass_completions, :passing_yards, :pass_touchdowns, :pass_interceptions, :passer_rating, :attempts_carries, :rush_yards, :rush_yards_att, :rush_longest, :rush_td, :received, :receiv_yards, :receiv_avg, :receiv_long, :receiv_touchdowns, :kick_xpm, :kick_xpa, :kick_xpp, :kick_fgm, :kick_fga, :kick_fgp, :kick_longest, :kick_op, :defense_tackles_solo, :defense_tackles_assist, :defense_sacks, :defense_fumbles, :defense_interceptions, :defense_yards, :defense_longest, :defense_td


  belongs_to :user, touch: true

  validates :number_of_games_played, :pass_attempts, :pass_completions, :passing_yards, :pass_touchdowns, :pass_interceptions, :passer_rating, :attempts_carries, :rush_yards, :rush_yards_att, :rush_longest, :rush_td, :received, :receiv_yards, :receiv_avg, :receiv_long, :receiv_touchdowns, :kick_xpm, :kick_xpa, :kick_xpp, :kick_fgm, :kick_fga, :kick_fgp, :kick_longest, :kick_op, :defense_tackles_solo, :defense_tackles_assist, :defense_sacks, :defense_fumbles, :defense_interceptions, :defense_yards, :defense_longest, :defense_td, :numericality => { :allow_blank => true, :only_integer => true }


  def self.labels
    {
      :pass_attempts => { :desc => "Total number of attempted passes", :label => "Attempts", :short => "Att", :section => "Passing" },
      :pass_completions => { :desc => "Total number of complete passes.", :label => "Pass Completions", :short => "Cmp", :section => "Passing" },
      :passing_yards => { :desc => "Total number of completed passing yards accumulated during the game", :label => "Passing yards", :short => "Yds", :section => "Passing" },
      :pass_touchdowns => { :desc => "Total number of completed touchdown passes thrown by the quarterback.", :label => "Touchdown Passes", :short => "TD", :section => "Passing" },
      :pass_interceptions => { :desc => "Pass interceptions", :label => "interceptions", :short => "INT", :section => "Passing" },
      :passer_rating => { :desc => "Passer rating", :label => "Passer rating", :short => "PR", :section => "Passing" },
      :attempts_carries => { :desc => "Attempts carries", :label => "Attempts carries", :short => "RC", :section => "Rushing" },
      :rush_yards => { :desc => "Rushing Yards", :label => "Yards", :short => "Yds", :section => "Rushing" },
      :rush_yards_att => { :desc => "Yards per attempt", :label => "Yards per attempt", :short => "Yatt", :section => "Rushing" },
      :rush_longest => { :desc => "Long(est gain)", :label => "Long(est gain)", :short => "Lng", :section => "Rushing" },
      :rush_td => { :desc => "Touchdowns", :label => "Touchdowns", :short => "TD", :section => "Rushing" },
      :received => { :desc => "Received", :label => "Received", :short => "Rec", :section => "Receiving" },
      :receiv_yards => { :desc => "Yards", :label => "Yards", :short => "Yds", :section => "Receiving" },
      :receiv_avg => { :desc => "Average", :label => "Average", :short => "Avg", :section => "Receiving" },
      :receiv_long => { :desc => "Long", :label => "Long", :short => "Lng", :section => "Receiving" },
      :receiv_touchdowns => { :desc => "Touchdowns", :label => "Touchdowns", :short => "TD", :section => "Receiving" },
      :kick_xpm => { :desc => "Extra points made", :label => "Extra points made", :short => "XPM", :section => "Kicking" },
      :kick_xpa => { :desc => "Extra points attempts", :label => "Extra points attempts", :short => "XPA", :section => "Kicking" },
      :kick_xpp => { :desc => "Extra points percentage", :label => "Extra points %", :short => "XP%", :section => "Kicking" },
      :kick_fgm => { :desc => "Field goal made", :label => "Field goal made", :short => "FGM", :section => "Kicking" },
      :kick_fga => { :desc => "Field goal attempts", :label => "Field goal attempts", :short => "FGA", :section => "Kicking" },
      :kick_fgp => { :desc => "Field goal percentage", :label => "Field goal %", :short => "FG%", :section => "Kicking" },
      :kick_longest => { :desc => "Longest", :label => "Longest", :short => "Lng", :section => "Kicking" },
      :kick_op => { :desc => "Overall points", :label => "Overall points", :short => "OP", :section => "Kicking" },
      :defense_tackles_solo => { :desc => "Tackles solo", :label => "Tackles solo", :short => "SOLO", :section => "Defense" },
      :defense_tackles_assist => { :desc => "Tackles assist", :label => "Tackles assist", :short => "Ast", :section => "Defense" },
      :defense_sacks => { :desc => "Sacks", :label => "sacks", :short => "SAK", :section => "Defense" },
      :defense_fumbles => { :desc => "Fumbles", :label => "Fumbles", :short => "Fumb", :section => "Defense" },
      :defense_interceptions => { :desc => "Interceptions", :label => "Interceptions", :short => "INT", :section => "Defense" },
      :defense_yards => { :desc => "Yards/interception", :label => "Yards/interception", :short => "Yds", :section => "Defense" },
      :defense_longest => { :desc => "Longest (int)", :label => "Longest (int)", :short => "Lng", :section => "Defense" },
      :defense_td => { :desc => "Touchdowns (from int)", :label => "Touchdowns (from int)", :short => "TD", :section => "Defense" }
    }
  end

end

