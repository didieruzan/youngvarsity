# == Schema Information
#
# Table name: baseball_stats
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string(255)
#  user_id             :integer
#  is_active           :boolean
#  games_played        :integer
#  batting_average     :integer
#  on_base_percentage  :integer
#  run_batted_in       :integer
#  hits                :integer
#  runs                :integer
#  plate_appearances   :integer
#  at_bat              :integer
#  home_runs           :integer
#  putout              :integer
#  assists             :integer
#  fielding_errors     :integer
#  total_chances       :integer
#  fielding_percentage :integer
#  stolen_bases        :integer
#  caught_stealing     :integer
#  earned_run_average  :integer
#  win                 :integer
#  loss                :integer
#  hits_against        :integer
#  runs_against        :integer
#  earned_runs         :integer
#  inning_pitched      :integer
#  pitching_save       :integer
#  strikeout           :integer
#

class BaseballStat < ActiveRecord::Base
  # attr_accessible :title, :body


  attr_accessible :is_active, :title, :user_id, :games_played, :batting_average, :on_base_percentage, :run_batted_in, :hits, :runs, :plate_appearances, :at_bat, :home_runs, :putout, :assists, :fielding_errors,:total_chances, :fielding_percentage, :stolen_bases, :caught_stealing, :earned_run_average, :win, :loss, :hits_against, :runs_against, :earned_runs, :inning_pitched, :pitching_save, :strikeout

  belongs_to :user, touch: true

  validates :games_played, :batting_average, :on_base_percentage, :run_batted_in, :hits, :runs, :plate_appearances, :at_bat, :home_runs, :putout, :assists, :fielding_errors,:total_chances, :fielding_percentage, :stolen_bases, :caught_stealing, :earned_run_average, :win, :loss, :hits_against, :runs_against, :earned_runs, :inning_pitched, :pitching_save, :strikeout,
    :numericality => { :allow_blank => true, :only_integer => true }



def self.labels
    {
    :games_played => { :desc => "Games played", :label => "Games played", :short => "G", :section => "General" },
    :batting_average => { :desc => "Batting average", :label => "Batting average", :short => "BA", :section => "Batting" },
    :on_base_percentage => { :desc => "On base percentage", :label => "On base percentage", :short => "OBA", :section => "Batting" },
    :run_batted_in => { :desc => "Run Batted In", :label => "Run Batted In", :short => "RBI", :section => "Batting" },
    :hits => { :desc => "Hits", :label => "Hits", :short => "HIT", :section => "Batting" },
    :runs => { :desc => "Runs", :label => "Runs", :short => "RUN", :section => "Batting" },
    :plate_appearances => { :desc => "Plate Appearances", :label => "Plate Appearances", :short => "PA", :section => "Batting" },
    :at_bat => { :desc => "at bat", :label => "at bat", :short => "AB", :section => "Batting" },
    :home_runs => { :desc => "Home runs", :label => "Home runs", :short => "HR", :section => "Batting" },
    :putout => { :desc => "putOut", :label => "putOut", :short => "PO", :section => "Fielding" },
    :assists => { :desc => "Assists", :label => "Assists", :short => "A", :section => "Fielding" },
    :fielding_errors => { :desc => "Errors", :label => "Errors", :short => "E", :section => "Fielding" },
    :total_chances => { :desc => "Total Chances", :label => "Total Chances", :short => "TC", :section => "Fielding" },
    :fielding_percentage => { :desc => "Fielding percentage", :label => "Fielding percentage", :short => "FP", :section => "Fielding" },
    :stolen_bases => { :desc => "Stolen bases", :label => "Stolen bases", :short => "SB", :section => "Base running" },
    :caught_stealing => { :desc => "Caught stealing", :label => "Caught stealing", :short => "CS", :section => "Base running" },
    :earned_run_average => { :desc => "Earned run average", :label => "Earned run average", :short => "ERA", :section => "Pitching" },
    :win => { :desc => "Win", :label => "Win", :short => "W", :section => "Pitching" },
    :loss => { :desc => "Loss", :label => "Loss", :short => "L", :section => "Pitching" },
    :hits_against => { :desc => "Hits against", :label => "Hits against", :short => "H", :section => "Pitching" },
    :runs_against => { :desc => "Runs against", :label => "Runs against", :short => "R", :section => "Pitching" },
    :earned_runs => { :desc => "Earned runs", :label => "Earned runs", :short => "ER", :section => "Pitching" },
    :inning_pitched => { :desc => "Inning pitched", :label => "Inning pitched", :short => "IP", :section => "Pitching" },
    :pitching_save => { :desc => "Save", :label => "Save", :short => "SV", :section => "Pitching" },
    :strikeout => { :desc => "Strikeout", :label => "Strikeout", :short => "K", :section => "Pitching" },
    }
end


end
