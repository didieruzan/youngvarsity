class AddOrientationToCollections < ActiveRecord::Migration
  def change
    add_column :collectibles, :orientation, :string
  end
end
