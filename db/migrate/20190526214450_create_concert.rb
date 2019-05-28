class CreateConcert < ActiveRecord::Migration[5.2]
   def change
      create_table :concerts do |t|
         t.string :name
         t.integer :price
         t.datetime :date
         t.datetime :start_time
         t.datetime :end_time
         t.string :website_url
         t.integer :artist_id
         t.integer :venue_id
      end
   end
end
