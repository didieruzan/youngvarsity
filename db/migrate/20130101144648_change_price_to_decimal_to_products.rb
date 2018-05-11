class ChangePriceToDecimalToProducts < ActiveRecord::Migration
  def up
    change_column :products, :price, :decimal, :precision => 6, :scale => 2
  end

  def down
  end
end
