class AddIsActiveToProduct < ActiveRecord::Migration
  def change
    	add_column :products, :is_active, :boolean
  end
end


