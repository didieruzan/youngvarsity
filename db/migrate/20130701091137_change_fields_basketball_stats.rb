class ChangeFieldsBasketballStats < ActiveRecord::Migration
  def change

    remove_column :basketball_stats,  :number_of_games_played
    remove_column :basketball_stats,  :number_of_games_started
    remove_column :basketball_stats,  :minutes
    remove_column :basketball_stats,  :minutes_per_game
    remove_column :basketball_stats,  :points
    remove_column :basketball_stats,  :points_per_game
    remove_column :basketball_stats,  :field_goals_made
    remove_column :basketball_stats,  :field_goals_attempts
    remove_column :basketball_stats,  :field_goal_percent
    remove_column :basketball_stats,  :three_points_made
    remove_column :basketball_stats,  :three_points_attempts
    remove_column :basketball_stats,  :three_points_percentage
    remove_column :basketball_stats,  :three_points_per_game
    remove_column :basketball_stats,  :freethrows_made
    remove_column :basketball_stats,  :freethrows_attempted
    remove_column :basketball_stats,  :freethrows_percentage
    remove_column :basketball_stats,  :turnovers
    remove_column :basketball_stats,  :turnovers_per_game
    remove_column :basketball_stats,  :blocked_shots
    remove_column :basketball_stats,  :blocks_per_game
    remove_column :basketball_stats,  :rebounds
    remove_column :basketball_stats,  :rebounds_per_game
    remove_column :basketball_stats,  :offensive_rebounds
    remove_column :basketball_stats,  :defensive_rebounds
    remove_column :basketball_stats,  :steals
    remove_column :basketball_stats,  :steals_per_game
    remove_column :basketball_stats,  :assists
    remove_column :basketball_stats,  :assists_per_game
    remove_column :basketball_stats,  :charges
    remove_column :basketball_stats,  :charges_per_game

    add_column :basketball_stats,  :games_played, :integer
    add_column :basketball_stats,  :point_game, :integer
    add_column :basketball_stats,  :assist_game, :integer
    add_column :basketball_stats,  :rebounds_game, :integer
    add_column :basketball_stats,  :field_goal, :integer
    add_column :basketball_stats,  :three_pt_percentage, :integer
    add_column :basketball_stats,  :ft_percentage, :integer
    add_column :basketball_stats,  :steals_game, :integer
    add_column :basketball_stats,  :blocks_game, :integer

  end
end
