class RemGamesPlayedFromFootballstats < ActiveRecord::Migration
  def change
    remove_column :football_stats, :games_played
    remove_column :football_stats,  :pass_completions
    remove_column :football_stats,  :pass_attempts
    remove_column :football_stats,  :pass_interceptions
    remove_column :football_stats,  :passing_yards
    remove_column :football_stats,  :tounchdown_passes
    remove_column :football_stats,  :longest_pass
    remove_column :football_stats,  :number_of_carries
    remove_column :football_stats,  :rushing_yards
    remove_column :football_stats,  :longest_rush
    remove_column :football_stats,  :number_of_receptions
    remove_column :football_stats,  :receiving_yards
    remove_column :football_stats,  :longest_reception
    remove_column :football_stats,  :pancake_blocks
    remove_column :football_stats,  :solo_tackles
    remove_column :football_stats,  :assisted_tackles
    remove_column :football_stats,  :sacks
    remove_column :football_stats,  :interception
    remove_column :football_stats,  :assists_per_game_avg
    remove_column :football_stats,  :fumbles_retrieved
    remove_column :football_stats,  :blocked_punts
    remove_column :football_stats,  :blocked_kicks
    remove_column :football_stats,  :field_goal_attempts
    remove_column :football_stats,  :field_goal_successful
    remove_column :football_stats,  :longest_field_goal
    remove_column :football_stats,  :total_points_per_game_avg
  end


end
