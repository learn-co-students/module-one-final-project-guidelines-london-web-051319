class AmendTickets < ActiveRecord::Migration[5.2]
   def change
      rename_column :tickets, :venue_id, :concert_id
   end
end
