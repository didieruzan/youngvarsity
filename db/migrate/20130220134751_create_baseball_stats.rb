class CreateBaseballStats < ActiveRecord::Migration
  def change
    create_table :baseball_stats do |t|

      t.timestamps
    end
  end
end
