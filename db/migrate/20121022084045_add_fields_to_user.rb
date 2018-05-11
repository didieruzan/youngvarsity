class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bg_image_uid, :string
    add_column :users, :bg_image_name, :string
    add_column :users, :bio, :text
    add_column :users, :sport, :string
    add_column :users, :team_name, :string
  end
end
