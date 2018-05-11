class AddSchoolNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :box_pos, :string, :default => 'right'
    add_column :users, :box_text_col, :string, :default => 'E2DFDD'
    add_column :users, :field_pos, :string
    add_column :users, :school_name, :string
  end
end
