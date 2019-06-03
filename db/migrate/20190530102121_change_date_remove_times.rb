class ChangeDateRemoveTimes < ActiveRecord::Migration[5.2]
   def change
      change_column :concerts, :date, :string
      remove_column :concerts, :start_time
      remove_column :concerts, :end_time
   end
end
