class CreateVenues < ActiveRecord::Migration[5.2]
   def change
      create_table :venues do |t|
         t.string :name
         t.string :website_url
         t.string :location
         t.string :facilities
      end
   end
end
