class ChangeFieldsSoccerStats < ActiveRecord::Migration
  def change
    remove_column :soccer_stats,  :number_of_games_played
    remove_column :soccer_stats,  :minutes_played
    remove_column :soccer_stats,  :minutes_played_per_game_on_average
    remove_column :soccer_stats,  :yellow_cards
    remove_column :soccer_stats,  :number_of_goals
    remove_column :soccer_stats,  :number_of_goals_per_game_on_average
    remove_column :soccer_stats,  :assists
    remove_column :soccer_stats,  :assists_per_game_on_average
    remove_column :soccer_stats,  :defense
    remove_column :soccer_stats,  :number_of_saves_on_goal
    remove_column :soccer_stats,  :saves_per_game_on_average

    add_column :soccer_stats,  :games_played, :integer
    add_column :soccer_stats,  :goals, :integer
    add_column :soccer_stats,  :assists, :integer
    add_column :soccer_stats,  :shots, :integer
    add_column :soccer_stats,  :shot_avg, :integer
    add_column :soccer_stats,  :saves_on_goals, :integer
  end
end
