class AddNewStatsToFootballstats < ActiveRecord::Migration
  def change
    add_column :football_stats, :number_of_games_played, :integer
    add_column :football_stats, :touchdowns, :integer
    add_column :football_stats, :touchdowns_per_game, :integer
    add_column :football_stats, :pass_attempts, :integer
    add_column :football_stats, :pass_completion, :integer
    add_column :football_stats, :completion_percentage, :integer
    add_column :football_stats, :passes_interceptions, :integer
    add_column :football_stats, :passing_yards, :integer
    add_column :football_stats, :passing_yards_per_game, :integer
    add_column :football_stats, :touchdown_passes, :integer
    add_column :football_stats, :longest_pass, :integer
    add_column :football_stats, :total_rushing_carries, :integer
    add_column :football_stats, :rushing_carries_per_game, :integer
    add_column :football_stats, :rushing_yards, :integer
    add_column :football_stats, :rushing_yards_per_game, :integer
    add_column :football_stats, :rushing_yards_per_carry, :integer
    add_column :football_stats, :rushing_tds, :integer
    add_column :football_stats, :offensive_fumbles, :integer
    add_column :football_stats, :rushing_longest, :integer
    add_column :football_stats, :total_receives, :integer
    add_column :football_stats, :receives_per_game, :integer
    add_column :football_stats, :receiving_yards, :integer
    add_column :football_stats, :receiving_yards_per_game, :integer
    add_column :football_stats, :receiving_yards_per_catch, :integer
    add_column :football_stats, :receiving_tds, :integer
    add_column :football_stats, :longest_catch, :integer
    add_column :football_stats, :total_tackles, :integer
    add_column :football_stats, :solo_tackles, :integer
    add_column :football_stats, :assists, :integer
    add_column :football_stats, :solo_tackles_per_game, :integer
    add_column :football_stats, :assists_per_game, :integer
    add_column :football_stats, :sacks, :integer
    add_column :football_stats, :fumbles_retrieved, :integer
    add_column :football_stats, :safety_scored, :integer
    add_column :football_stats, :special_teams, :integer
    add_column :football_stats, :fg_attempts, :integer
    add_column :football_stats, :fg_made, :integer
    add_column :football_stats, :fg_percentage, :integer
    add_column :football_stats, :longest_fg, :integer
  end
end
