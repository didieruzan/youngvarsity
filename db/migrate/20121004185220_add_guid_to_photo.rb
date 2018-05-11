class AddGuidToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :guid, :string
  end
end
