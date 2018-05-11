class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :manufacturer
      t.string :title
      t.text :description_short
      t.text :description
      t.integer :price
      t.string :url

      t.timestamps
    end
  end
end
