class CreateCollectibles < ActiveRecord::Migration
  def change
    create_table :collectibles do |t|
      t.string :srcphoto
      t.integer :user_id
      t.integer :stat_id
      t.string :field_pos
      t.string :team_name
      t.integer :jersey_num
      t.string :photo_front
      t.string :photo_back
      t.string :style

      t.timestamps
    end
  end
end
