class AddFieldsToSoccerStats < ActiveRecord::Migration
  def change
    add_column :soccer_stats, :title, :string
    add_column :soccer_stats, :user_id, :integer
    add_column :soccer_stats, :number_of_games_played, :integer
    add_column :soccer_stats, :minutes_played, :integer
    add_column :soccer_stats, :minutes_played_per_game_on_average, :integer
    add_column :soccer_stats, :yellow_cards, :integer
    add_column :soccer_stats, :number_of_goals, :integer
    add_column :soccer_stats, :number_of_goals_per_game_on_average, :integer
    add_column :soccer_stats, :assists, :integer
    add_column :soccer_stats, :assists_per_game_on_average, :integer
    add_column :soccer_stats, :defense, :integer
    add_column :soccer_stats, :number_of_saves_on_goal, :integer
    add_column :soccer_stats, :saves_per_game_on_average, :integer
    add_column :soccer_stats, :is_active, :boolean
  end
end
