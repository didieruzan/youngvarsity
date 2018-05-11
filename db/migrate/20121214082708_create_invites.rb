class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string   :token
      t.boolean  :is_active, :default => true
      t.integer  :date_used
      t.integer  :sender
      t.integer  :recipient
      t.timestamps
    end
  end
end
