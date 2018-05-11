class ModifyJerseynumToJerseyNumToUsers < ActiveRecord::Migration
 def change
    remove_column :users, :jerseynum
    add_column :users, :jersey_num, :integer
  end
end
