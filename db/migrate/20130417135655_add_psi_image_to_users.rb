class AddPsiImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :psi_image_med_uid, :string
    add_column :users, :psi_image_framed_uid, :string
  end
end
