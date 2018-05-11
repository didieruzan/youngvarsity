class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :guid
      t.string :nickname
      t.integer :dob
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :city
      t.string :state
      t.string :country
      t.string :local
      t.string :email,              :null => false, :default => ""
      t.string :facebook_id
      t.string :ipaddress

      t.timestamps
    end
  end
end
