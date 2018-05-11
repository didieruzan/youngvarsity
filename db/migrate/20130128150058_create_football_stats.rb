class CreateFootballStats < ActiveRecord::Migration
  def change
    create_table :football_stats do |t|
      t.string :title
      t.integer :user_id
      t.integer :games_played
      t.integer :pass_completions
      t.integer :pass_attempts
      t.integer :pass_interceptions
      t.integer :passing_yards
      t.integer :tounchdown_passes
      t.integer :longest_pass
      t.integer :number_of_carries
      t.integer :rushing_yards
      t.integer :longest_rush
      t.integer :number_of_receptions
      t.integer :receiving_yards
      t.integer :longest_reception
      t.integer :pancake_blocks
      t.integer :solo_tackles
      t.integer :assisted_tackles
      t.integer :sacks
      t.integer :interception
      t.integer :assists_per_game_avg
      t.integer :fumbles_retrieved
      t.integer :blocked_punts
      t.integer :blocked_kicks
      t.integer :field_goal_attempts
      t.integer :field_goal_successful
      t.integer :longest_field_goal
      t.integer :total_points_per_game_avg
      t.boolean :is_active

      t.timestamps
    end
  end
end
