class Venue < ActiveRecord::Base
   has_many :concerts
   has_many :artists, through: :concerts

   # CLASS *********************

   # def self.average_total_revenue
   #    will require tickets and users
   # end

   def self.find_venue_by_email(email_address) #this method is used to check the email address for sign in in cli.rb
      self.where(["email = ?", email_address]).first
   end

   # INSTANCE *****************

   def update_email(new_email)
      self.update(email: new_email)
   end

   def update_password(new_password)
      self.update(password: new_password)
   end

   def my_concerts
      Concert.all.select{|inst| inst.venue_id == self.id}
   end

   def my_concerts_list
      concerts = Concert.all.select{|inst| inst.venue_id == self.id}
      list = concerts.map(&:name)
      puts list
   end

   def my_artists
      bands = self.my_concerts.map{|inst| inst.artist_id}
      Artist.all.select{|inst| bands.include?(inst.id)} 
   end

   def my_artists_list
      bands = self.my_concerts.map{|inst| inst.artist_id}
      artists = Artist.all.select{|inst| bands.include?(inst.id)} 
      list = artists.map(&:name)
      puts list
   end

   #most important functionality (through venue portal i think) is to create a concert, assign an artist, assign tickets, assign a venue and view ticket sales for that concert.. 

   #idea for a method, launch the location in google maps.
   #pull venue info from an api to get the lat/longitude

   #idea for a method, use faker to generate thousands of users/tickets and check sales vs stadium capacity

end