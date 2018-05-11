class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :url

      t.timestamps
    end
  end
end
