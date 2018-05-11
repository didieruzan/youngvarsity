class AddFieldsToBasketballStats < ActiveRecord::Migration
  def change
    add_column :basketball_stats, :title, :string
    add_column :basketball_stats, :user_id, :integer
    add_column :basketball_stats, :number_of_games_played, :integer
    add_column :basketball_stats, :number_of_games_started, :integer
    add_column :basketball_stats, :minutes, :integer
    add_column :basketball_stats, :minutes_per_game, :integer
    add_column :basketball_stats, :points, :integer
    add_column :basketball_stats, :points_per_game, :integer
    add_column :basketball_stats, :field_goals_made, :integer
    add_column :basketball_stats, :field_goals_attempts, :integer
    add_column :basketball_stats, :field_goal_percent, :integer
    add_column :basketball_stats, :three_points_made, :integer
    add_column :basketball_stats, :three_points_attempts, :integer
    add_column :basketball_stats, :three_points_percentage, :integer
    add_column :basketball_stats, :three_points_per_game, :integer
    add_column :basketball_stats, :freethrows_made, :integer
    add_column :basketball_stats, :freethrows_attempted, :integer
    add_column :basketball_stats, :freethrows_percentage, :integer
    add_column :basketball_stats, :turnovers, :integer
    add_column :basketball_stats, :turnovers_per_game, :integer
    add_column :basketball_stats, :blocked_shots, :integer
    add_column :basketball_stats, :blocks_per_game, :integer
    add_column :basketball_stats, :rebounds, :integer
    add_column :basketball_stats, :rebounds_per_game, :integer
    add_column :basketball_stats, :offensive_rebounds, :integer
    add_column :basketball_stats, :defensive_rebounds, :integer
    add_column :basketball_stats, :steals, :integer
    add_column :basketball_stats, :steals_per_game, :integer
    add_column :basketball_stats, :assists, :integer
    add_column :basketball_stats, :assists_per_game, :integer
    add_column :basketball_stats, :charges, :integer
    add_column :basketball_stats, :charges_per_game, :integer
    add_column :basketball_stats, :is_active, :boolean
  end
end
