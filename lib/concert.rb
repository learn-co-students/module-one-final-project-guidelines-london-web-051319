class Concert < ActiveRecord::Base
   has_many :tickets
   has_many :users, through: :tickets

   # CLASS ***********************

   def self.all_concerts_by_artist(artist_name)
      band = Artist.all.select{|inst| inst.name == artist_name}.first
      Concert.all.select{|inst| inst.artist_id == band.id }
   end

   def self.all_concerts_by_venue(venue_name)
      ven = Venue.all.select{|inst| inst.name == venue_name}.first
      Concert.all.select{|inst| inst.venue_id == ven.id}
   end

   def self.most_expensive_concert
      ticket = {}
      concert = Concert.all.max_by{|inst| inst.price}
      ticket[concert.name] = "£#{concert.price}"
      ticket
   end

   def self.find_venue_by_email(email_address) #this method is used to check the email address for sign in in cli.rb
      self.where(["email = ?", email_address]).first
   end

   # INSTANCE *******************

   def ticket_price
      Concert.all.find{|inst| inst.name == self.name}.price
   end

   def ticket_price_gbp 
      "£#{self.ticket_price}"
   end

   def all_tickets #returns all tickets for a concert
      Ticket.all.select{|ticket|ticket.concert_id == self.id}
   end

   def tickets_sold #returns a numerical count of all tickets assigned to a concert
      all_tickets.count
   end

   def venue #returns the venue instance which matches the venue.id of the concert 
      Venue.all.select { |a_venue| a_venue.id == self.venue_id }.first
   end

   def venue_name #returns the name of the venue for a concert
      venue.name
   end

   # def venue_capacity
   #    venue.capacity
   # end

   def artists
      Artist.all.select { |an_artist| an_artist.id == self.artist_id }
   end

   def artists_names
      artists.map { |artist| artist.name }
   end

   def status
      puts "Venue: #{venue_name}"
      # venue_capacity
      puts "Tickets sold: #{tickets_sold}"
      # "Tickets available: #{venue_capacity - tickets_sold}"
      puts "Artist(s) appearing: #{artists_names}"
   end
end