class AddMoreCards < ActiveRecord::Migration[5.2]
   def change
      rename_column :users, :card_number, :card_1_number
      add_column :users, :card_2_number, :integer
      add_column :users, :card_3_number, :integer
   end
end
