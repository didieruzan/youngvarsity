class ModifyStatidToLatestStatsToCollectibles < ActiveRecord::Migration
  def change
    remove_column :collectibles, :stat_id
    add_column :collectibles, :latest_stats, :string
  end
end
