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

   def artist
      Artist.all.find{|inst|inst.id == self.artist_id}
   end

   def customers
      tickets = Ticket.all.select{|inst|inst.concert_id == self.id}
      User.all.select{|inst| tickets.map(&:user_id).include?(inst.id)}
   end

end