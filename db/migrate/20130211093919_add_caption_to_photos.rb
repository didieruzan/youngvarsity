class AddCaptionToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :description, :string
  end
end
