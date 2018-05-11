class AddFields1ToCollectibles < ActiveRecord::Migration
  def change
    add_column :collectibles, :to_print, :boolean
  end
end
