# == Schema Information
#
# Table name: basketball_stats
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string(255)
#  user_id             :integer
#  is_active           :boolean
#  games_played        :integer
#  point_game          :integer
#  assist_game         :integer
#  rebounds_game       :integer
#  field_goal          :integer
#  three_pt_percentage :integer
#  ft_percentage       :integer
#  steals_game         :integer
#  blocks_game         :integer
#

class BasketballStat < ActiveRecord::Base

  attr_accessible :is_active, :title, :user_id, :games_played, :point_game, :assist_game, :rebounds_game, :field_goal, :three_pt_percentage, :ft_percentage, :steals_game, :blocks_game


  belongs_to :user, touch: true

  validates :games_played, :point_game, :assist_game, :rebounds_game, :field_goal, :three_pt_percentage, :ft_percentage, :steals_game, :blocks_game, :numericality => { :allow_blank => true, :only_integer => true }




    def self.labels
        {
          :games_played =>    { :desc => "Games played", :label => "Games played", :short => "GP", :section => "General" },
          :point_game =>      { :desc => "Point per game", :label => "Point per game", :short => "Points", :section => "Offense/Defense" },
          :assist_game =>     { :desc => "Assist per game", :label => "Assist per game", :short => "Assits", :section => "Offense/Defense" },
          :rebounds_game =>   { :desc => "Rebounds per game", :label => "Rebounds per game", :short => "Rebounds", :section => "Offense/Defense" },
          :field_goal =>      { :desc => "Field goal percentage", :label => "Field goal %", :short => "Field goal %", :section => "Offense/Defense" },
          :three_pt_percentage =>    { :desc => "3pt. percentage", :label => "3pt. %", :short => "3pt. %", :section => "Offense/Defense" },
          :ft_percentage =>   { :desc => "Free Throws Average", :label => "Free Throws %", :short => "FTA", :section => "Offense/Defense" },
          :steals_game =>    { :desc => "Steals per game", :label => "Steals per game", :short => "Steals", :section => "Offense/Defense" },
          :blocks_game =>    { :desc => "blocks per game", :label => "Blocks per game", :short => "Blocks", :section => "Offense/Defense" }
        }
    end

end
