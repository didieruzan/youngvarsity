class ModifyRecipientToStringForInvites < ActiveRecord::Migration
  def change
    remove_column :invitations, :recipient
    add_column :invitations, :recipient, :string
  end

end
