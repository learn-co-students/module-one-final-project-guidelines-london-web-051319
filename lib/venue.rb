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

   def update_name(new_name)
      self.update(name: new_name)
   end
  
   def update_email(new_email)
      self.update(email: new_email)
   end

   def update_password(new_password)
      self.update(password: new_password)
   end

   def update_website(new_url)
      self.update(website_url: new_url)
   end

   def update_location(new_location)
      self.update(location: new_location)
   end

   def update_facilities(*new_facilities)
      self.update(facilities: new_facilities)
   end

   def my_concerts
      Concert.all.select{|inst| inst.venue_id == self.id}
   end

   def my_concerts_list
      concerts = Concert.all.select{|inst| inst.venue_id == self.id}
      list = concerts.map{|inst| "#{inst.name} - #{inst.artist.name}"}
      puts list.collect{|inst| inst.colorize(:cyan)}
   end

   def my_artists
      bands = self.my_concerts.map{|inst| inst.artist_id}
      Artist.all.select{|inst| bands.include?(inst.id)} 
   end

   def my_artists_list
      bands = self.my_concerts.map{|inst| inst.artist_id}
      artists = Artist.all.select{|inst| bands.include?(inst.id)} 
      list = artists.map(&:name)
      puts list.collect{|inst| inst.colorize(:cyan)}
   end

end