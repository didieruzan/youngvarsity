class CreateSoccerStats < ActiveRecord::Migration
  def change
    create_table :soccer_stats do |t|

      t.timestamps
    end
  end
end
