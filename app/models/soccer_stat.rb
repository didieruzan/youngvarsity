# == Schema Information
#
# Table name: soccer_stats
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string(255)
#  user_id        :integer
#  is_active      :boolean
#  games_played   :integer
#  goals          :integer
#  assists        :integer
#  shots          :integer
#  shot_avg       :integer
#  saves_on_goals :integer
#

class SoccerStat < ActiveRecord::Base
  attr_accessible :title, :user_id, :games_played, :goals, :assists, :shots, :shot_avg, :saves_on_goals, :is_active

  belongs_to :user, touch: true

  validates :games_played, :goals, :assists, :shots, :shot_avg, :saves_on_goals, :numericality => { :allow_blank => true, :only_integer => true }


  def self.labels
      {
        :games_played =>    { :desc => "Games played", :label => "Games played", :short => "GP", :section => "General" },
        :goals =>    { :desc => "Goals", :label => "Goals", :short => "Goals", :section => "Offense/Defense" },
        :assists =>    { :desc => "Assists", :label => "Assists", :short => "Assists", :section => "Offense/Defense" },
        :shots =>    { :desc => "Shots", :label => "Shots", :short => "Shots", :section => "Offense/Defense" },
        :shot_avg =>    { :desc => "Shot percentage", :label => "Shot %", :short => "Shot %", :section => "Offense/Defense" },
        :saves_on_goals =>  { :desc => "Saves on goals", :label => "Saves on goals", :short => "Saves", :section => "Offense/Defense" }
      }


  end

end
