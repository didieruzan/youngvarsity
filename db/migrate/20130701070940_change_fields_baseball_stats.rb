class ChangeFieldsBaseballStats < ActiveRecord::Migration
  def change
    remove_column :baseball_stats,  :number_of_games_played
    remove_column :baseball_stats,  :at_bat
    remove_column :baseball_stats,  :hits
    remove_column :baseball_stats,  :batting_average
    remove_column :baseball_stats,  :doubles
    remove_column :baseball_stats,  :triples
    remove_column :baseball_stats,  :home_runs
    remove_column :baseball_stats,  :runs_batted_in
    remove_column :baseball_stats,  :sacrifice_fly
    remove_column :baseball_stats,  :slugging_percentage
    remove_column :baseball_stats,  :on_base_percentage
    remove_column :baseball_stats,  :base_on_balls
    remove_column :baseball_stats,  :hits_by_pitch
    remove_column :baseball_stats,  :reached_on_error
    remove_column :baseball_stats,  :strikeouts
    remove_column :baseball_stats,  :runs
    remove_column :baseball_stats,  :stolen_base
    remove_column :baseball_stats,  :stolen_base_attempts
    remove_column :baseball_stats,  :earned_runs
    remove_column :baseball_stats,  :earned_run_average
    remove_column :baseball_stats,  :runs_against
    remove_column :baseball_stats,  :innings_pitched_decimal
    remove_column :baseball_stats,  :hits_allowed
    remove_column :baseball_stats,  :homeruns_allowed
    remove_column :baseball_stats,  :win
    remove_column :baseball_stats,  :loss
    remove_column :baseball_stats,  :complete_games
    remove_column :baseball_stats,  :games_shutout
    remove_column :baseball_stats,  :base_on_ball
    remove_column :baseball_stats,  :batter_struck_out
    remove_column :baseball_stats,  :batters_faced
    remove_column :baseball_stats,  :fielding
    remove_column :baseball_stats,  :fielding_percentage
    remove_column :baseball_stats,  :put_outs
    remove_column :baseball_stats,  :put_outs_per_game
    remove_column :baseball_stats,  :assists
    remove_column :baseball_stats,  :assists_per_game
    remove_column :baseball_stats,  :errors_per_game
    remove_column :baseball_stats,  :total_chances
    remove_column :baseball_stats,  :total_tackles
    remove_column :baseball_stats,  :solo_tackles
    remove_column :baseball_stats,  :assists_tackles
    remove_column :baseball_stats,  :errors_count
    remove_column :baseball_stats,  :missed_pitches


    add_column :baseball_stats, :games_played, :integer
    add_column :baseball_stats, :batting_average, :integer
    add_column :baseball_stats, :on_base_percentage, :integer
    add_column :baseball_stats, :run_batted_in, :integer
    add_column :baseball_stats, :hits, :integer
    add_column :baseball_stats, :runs, :integer
    add_column :baseball_stats, :plate_appearances, :integer
    add_column :baseball_stats, :at_bat, :integer
    add_column :baseball_stats, :home_runs, :integer
    add_column :baseball_stats, :putout, :integer
    add_column :baseball_stats, :assists, :integer
    add_column :baseball_stats, :fielding_errors, :integer
    add_column :baseball_stats, :total_chances, :integer
    add_column :baseball_stats, :fielding_percentage, :integer
    add_column :baseball_stats, :stolen_bases, :integer
    add_column :baseball_stats, :caught_stealing, :integer
    add_column :baseball_stats, :earned_run_average, :integer
    add_column :baseball_stats, :win, :integer
    add_column :baseball_stats, :loss, :integer
    add_column :baseball_stats, :hits_against, :integer
    add_column :baseball_stats, :runs_against, :integer
    add_column :baseball_stats, :earned_runs, :integer
    add_column :baseball_stats, :inning_pitched, :integer
    add_column :baseball_stats, :pitching_save, :integer
    add_column :baseball_stats, :strikeout, :integer

  end

end
