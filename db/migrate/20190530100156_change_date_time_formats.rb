class ChangeDateTimeFormats < ActiveRecord::Migration[5.2]
   def change
      change_column :concerts, :date, :date
      change_column :concerts, :start_time, :time
      change_column :concerts, :end_time, :time
   end
end
