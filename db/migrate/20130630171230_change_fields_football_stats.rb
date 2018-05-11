class ChangeFieldsFootballStats < ActiveRecord::Migration
 def change
      remove_column :football_stats,  :touchdowns
      remove_column :football_stats,  :touchdowns_per_game
      remove_column :football_stats,  :pass_attempts
      remove_column :football_stats,  :pass_completion
      remove_column :football_stats,  :completion_percentage
      remove_column :football_stats,  :passes_interceptions
      remove_column :football_stats,  :passing_yards
      remove_column :football_stats,  :passing_yards_per_game
      remove_column :football_stats,  :touchdown_passes
      remove_column :football_stats,  :longest_pass
      remove_column :football_stats,  :total_rushing_carries
      remove_column :football_stats,  :rushing_carries_per_game
      remove_column :football_stats,  :rushing_yards
      remove_column :football_stats,  :rushing_yards_per_game
      remove_column :football_stats,  :rushing_yards_per_carry
      remove_column :football_stats,  :rushing_tds
      remove_column :football_stats,  :offensive_fumbles
      remove_column :football_stats,  :rushing_longest
      remove_column :football_stats,  :total_receives
      remove_column :football_stats,  :receives_per_game
      remove_column :football_stats,  :receiving_yards
      remove_column :football_stats,  :receiving_yards_per_game
      remove_column :football_stats,  :receiving_yards_per_catch
      remove_column :football_stats,  :receiving_tds
      remove_column :football_stats,  :longest_catch
      remove_column :football_stats,  :total_tackles
      remove_column :football_stats,  :solo_tackles
      remove_column :football_stats,  :assists
      remove_column :football_stats,  :solo_tackles_per_game
      remove_column :football_stats,  :assists_per_game
      remove_column :football_stats,  :sacks
      remove_column :football_stats,  :fumbles_retrieved
      remove_column :football_stats,  :safety_scored
      remove_column :football_stats,  :special_teams
      remove_column :football_stats,  :fg_attempts
      remove_column :football_stats,  :fg_made
      remove_column :football_stats,  :fg_percentage
      remove_column :football_stats,  :longest_fg


      add_column :football_stats, :pass_attempts, :integer
      add_column :football_stats, :pass_completions, :integer
      add_column :football_stats, :passing_yards, :integer
      add_column :football_stats, :pass_touchdowns, :integer
      add_column :football_stats, :pass_interceptions, :integer
      add_column :football_stats, :passer_rating, :integer
      add_column :football_stats, :attempts_carries, :integer
      add_column :football_stats, :rush_yards, :integer
      add_column :football_stats, :rush_yards_att, :integer
      add_column :football_stats, :rush_longest, :integer
      add_column :football_stats, :rush_td, :integer
      add_column :football_stats, :received, :integer
      add_column :football_stats, :receiv_yards, :integer
      add_column :football_stats, :receiv_avg, :integer
      add_column :football_stats, :receiv_long, :integer
      add_column :football_stats, :receiv_touchdowns, :integer
      add_column :football_stats, :kick_xpm, :integer
      add_column :football_stats, :kick_xpa, :integer
      add_column :football_stats, :kick_xpp, :integer
      add_column :football_stats, :kick_fgm, :integer
      add_column :football_stats, :kick_fga, :integer
      add_column :football_stats, :kick_fgp, :integer
      add_column :football_stats, :kick_longest, :integer
      add_column :football_stats, :kick_op, :integer
      add_column :football_stats, :defense_tackles_solo, :integer
      add_column :football_stats, :defense_tackles_assist, :integer
      add_column :football_stats, :defense_sacks, :integer
      add_column :football_stats, :defense_fumbles, :integer
      add_column :football_stats, :defense_interceptions, :integer
      add_column :football_stats, :defense_yards, :integer
      add_column :football_stats, :defense_longest, :integer
      add_column :football_stats, :defense_td, :integer

  end
end
