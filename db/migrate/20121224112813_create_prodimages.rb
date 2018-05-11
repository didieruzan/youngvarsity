class CreateProdimages < ActiveRecord::Migration
  def change
    create_table :prodimages do |t|
      t.integer :product_id
      t.string :image_uid

      t.timestamps
    end
  end
end
