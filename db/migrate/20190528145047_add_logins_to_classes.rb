class AddLoginsToClasses < ActiveRecord::Migration[5.2]
   def change
      add_column :users, :email, :string
      add_column :users, :password, :string
      add_column :artists, :email, :string
      add_column :artists, :password, :string
      add_column :venues, :email, :string
      add_column :venues, :password, :string
   end
end
