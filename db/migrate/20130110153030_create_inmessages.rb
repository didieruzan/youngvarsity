class CreateInmessages < ActiveRecord::Migration
  def change
    create_table :inmessages do |t|
      t.string :name
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
