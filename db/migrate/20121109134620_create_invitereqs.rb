class CreateInvitereqs < ActiveRecord::Migration
  def change
    create_table :invitereqs do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
