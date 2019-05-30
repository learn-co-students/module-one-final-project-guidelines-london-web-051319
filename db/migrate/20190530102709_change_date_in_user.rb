class ChangeDateInUser < ActiveRecord::Migration[5.2]
   def change
      change_column :users, :dob, :string
   end
end
