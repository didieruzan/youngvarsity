class AddFieldsToCollectibles < ActiveRecord::Migration
  def change
    add_column :collectibles, :shipping_address, :text
    add_column :collectibles, :phone, :string
  end
end
