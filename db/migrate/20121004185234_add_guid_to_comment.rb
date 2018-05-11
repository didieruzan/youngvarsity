class AddGuidToComment < ActiveRecord::Migration
  def change
    add_column :comments, :guid, :string
  end
end
