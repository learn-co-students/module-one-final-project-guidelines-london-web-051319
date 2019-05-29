class Artist < ActiveRecord::Base
   has_many :concerts
   has_many :venues, through: :concerts

   # CLASS ***********************

   def self.artists_schedules_by_name(artist_name)
      Artist.all.select{|inst| inst.name == band_name}[0].my_schedule
   end

   def self.find_artist_by_email(email_address) #this method is used to check the email address for sign in in cli.rb
      self.where(["email = ?", email_address]).first
   end

   # def self.average_total_revenue
   #    will require the user and ticket classes
   # end

   # INSTANCE *******************

   def my_schedule
      Concert.all.select{|inst| inst.artist_id == self.id}
   end

   def my_schedule_info
      sched = {:gigs => []}
      self.my_schedule.each do |inst|
         # binding.pry
         sched[:gigs] << {name: inst.name, date: inst.date, venue: Venue.all.find{|i| i.id == inst.venue_id}.name}
      end
      puts sched
   end

   def tickets_sold_concert(concert_name)
      event = self.my_schedule.find{|inst| inst.name == concert_name}
      self.tickets_sold_total.select{|inst| inst.concert_id == event.id}
      binding.pry
   end

   def number_tickets_sold_concert(concert_name)
      tickets_sold_concert(concert_name).count
   end

   def tickets_sold_total
      events = self.my_schedule.map{|inst| inst.id}.uniq
      Ticket.all.select{|inst| events.include?(inst.concert_id)}
   end

   def number_tickets_sold
      self.tickets_sold_total.count
   end
   
   def where_am_i_playing
      venues = self.my_schedule.map{|inst| inst.venue_id}
      Venue.all.select{|inst| venues.include?(inst.id)}
   end
   
   def my_ticket_prices(concert_name)
      self.my_schedule.select{|inst| inst.name == concert_name}.map{|inst| inst.price}.first
   end

   def my_earnings_concert(concert_name)
      # assume 25% for artists 
      self.my_ticket_prices(concert_name)*self.tickets_sold_concert(concert_name).count*0.25
   end

end

# Practice code

# def where_am_i_playing
#    my_venues = []
#    venues = self.my_schedule.map{|inst| inst.venue_id}
#    Venue.all.each do |inst| 
#       venues.each do |item|
#          inst.id == item ? my_venues << inst : nil
#       end
#    end
#    my_venues
# end