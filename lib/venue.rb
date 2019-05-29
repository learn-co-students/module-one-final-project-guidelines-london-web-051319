class Venue < ActiveRecord::Base
   has_many :concerts
   has_many :artists, through: :concerts

   # CLASS *********************

   # def self.average_total_revenue
   #    will require tickets and users
   # end

   # INSTANCE *****************

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

end