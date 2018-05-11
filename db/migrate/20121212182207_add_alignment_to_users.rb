class AddAlignmentToUsers < ActiveRecord::Migration
  def up
    	add_column :users, :align_landscape, :string, :default => 'top center'
    	add_column :users, :align_portrait,  :string, :default => 'center center'
	end
end
