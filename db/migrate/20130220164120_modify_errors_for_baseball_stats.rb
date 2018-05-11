class ModifyErrorsForBaseballStats < ActiveRecord::Migration
  def change
    remove_column :baseball_stats, :errors
    add_column :baseball_stats, :errors_count, :integer
  end
end
