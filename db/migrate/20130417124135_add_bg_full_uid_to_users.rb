class AddBgFullUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bg_full_uid, :string
  end
end
