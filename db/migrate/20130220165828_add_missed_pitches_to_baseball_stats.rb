class AddMissedPitchesToBaseballStats < ActiveRecord::Migration
  def change
    add_column :baseball_stats, :missed_pitches, :integer
  end
end
