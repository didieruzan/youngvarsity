class CreateBasketballStats < ActiveRecord::Migration
  def change
    create_table :basketball_stats do |t|

      t.timestamps
    end
  end
end
