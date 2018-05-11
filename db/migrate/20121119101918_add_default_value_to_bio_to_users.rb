class AddDefaultValueToBioToUsers < ActiveRecord::Migration
  	def up
    	change_column :users, :bio, :text, :default => ''
	end
end
