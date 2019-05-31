require "pry"

class Cli 
	def run # this will be the first method called by run.rb
		welcome_message
		sign_in_or_new
	end

	def welcome_message # called by run. outputs big mus.ic welcome screen.
		font = TTY::Font.new(:doom)
		pastel = Pastel.new
		puts pastel.magenta.on_white.bold(font.write("Mus.ic"))
		
	end

	def sign_in_or_new 	# called by run. appears at startup, gives the user 3 initial choices that call the methods below.
      puts "Hello! Welcome to Mus.ic".colorize(:magenta)
		prompt = TTY::Prompt.new
		choices = ["Sign In", "New User", "Exit"]
		response = prompt.select("Please select an option:".colorize(:magenta), choices)
			if response == "Sign In"
				sign_in
			elsif response == "New User"
				new_user_sign_up
			elsif response == "Exit"
				exit_menu
			end
	end

	def sign_in #asks for email, checks against 3 tables for a record. Returns the record as @current_user and launches the correct portal.
		
      puts "Mus.ic sign in".colorize(:cyan)
		prompt = TTY::Prompt.new
      email = prompt.ask('Please enter the email address you signed up with'.colorize(:magenta), default: ENV['yourname@gmail.com'])
      password = prompt.mask("Please enter your password:".colorize(:magenta)) # requst password and obscure entry
      validate(email, password)
	end
   
   def validate(user_email, user_password) # called by sign_in. Sorts user into class and validates email and password against database
      if User.all.map(&:email).include?(user_email) == true
         # binding.pry
         customer = User.all.find{|inst|inst.email == user_email}
         if customer.password == user_password
            customer_portal(customer)
         else
            failed_sign_in
         end
      elsif Artist.all.map(&:email).include?(user_email) == true
         artist = Artist.all.find{|inst|inst.email == user_email}
         if artist.password == user_password
            artist_portal(artist)
         else
            failed_sign_in
         end
      elsif Venue.all.map(&:email).include?(user_email) == true
         venue = Venue.all.find{|inst|inst.email == user_email}
         if venue.password == user_password
            venue_portal(venue)
         else
            failed_sign_in
         end
      else
         failed_sign_in
      end
   end

   def failed_sign_in
      prompt  = TTY::Prompt.new
      puts "The username and/or password provided are incorrect. Please try again.".colorize(:red)
      sign_in_or_new
   end

	def new_user_sign_up
      prompt = TTY::Prompt.new
      choices = ["Customer", "Artist", "Venue Manager", "Log out"]
      response = prompt.select("Welcome to Mus.ic! Please let us know which account you would like to create:".colorize(:magenta), choices)

      if response == "Customer"
         result = prompt.collect do
            key(:name).ask('Please enter your name:'.colorize(:cyan))
            key(:email).ask('Please enter your email:'.colorize(:cyan)){|q| q.validate :email}
            key(:password).ask('Please enter a new password:'.colorize(:cyan))
            key(:dob).ask('Please enter your date of birth (yyyy-mm-dd):'.colorize(:cyan), convert: :date)
         end

         #we need to check if email already exists and divert to log in if appropriate
         if User.all.map(&:email).include?(result[:email])
            puts "An account already exists for this email address, please login.".colorize(:red)
            sign_in_or_new
         else
            @current_user = User.create(result)
            puts "Thank you, #{@current_user.name}. Your account is now live! Welcome to Mus.ic!".colorize(:green)
            customer_portal(@current_user)
         end
         
      elsif response == "Artist"
         result = prompt.collect do
            key(:name).ask('Please enter your name:'.colorize(:cyan))
            key(:email).ask('Please enter your email address:'.colorize(:cyan)){|q| q.validate :email}
            key(:password).ask('Please enter a new password:'.colorize(:cyan))
         end

         if Artist.all.map(&:email).include?(result[:email])
            puts "An account already exists for this email address, please login.".colorize(:red)
            sign_in_or_new
         else
            @current_user = Artist.create(result)
            puts "Thank you, #{@current_user.name}. Your account is now live! Welcome to Mus.ic!".colorize(:green)
            artist_portal(@current_user)
         end

         # Artist.create(new_text)
      elsif response == "Venue Manager"
         result = prompt.collect do
            key(:name).ask('Please enter the name of your venue:'.colorize(:magenta))
            key(:email).ask('Please enter a valid email address:'.colorize(:magenta)){|q| q.validate :email}
            key(:password).ask('Please enter a new password:'.colorize(:magenta))
            key(:location).ask('Please enter the city and country in which your venue is located:'.colorize(:magenta))
            key(:facilites).key('Please provide details of the facilities available at your venue:'.colorize(:magenta))
            key(:website).key('Please enter a valid website address for your venue'.colorize(:magenta))
         end

         if User.all.map(&:email).include?(result[:email])
            puts "An account already exists for this email address, please login.".colorize(:red)
            sign_in_or_new
         else
            @current_user = Venue.create(result)
            puts "Thank you for creating a venue account for #{@current_user.name}. Your account is now live! Welcome to Mus.ic!".colorize(:green)
            venue_portal(@current_user)
         end
         # Venue.create(new_text)
      elsif response == "Log out"
         sign_in_or_new
      end
	end
	
	def exit_menu
		puts "Thank you for using mus.ic, Goodbye.".colorize(:magenta)
		exit
	end

  # GLOBAL


# ARTIST

def update_artist_account(user) # will allow the user to update contact details
   prompt = TTY::Prompt.new
   response = prompt.select("Please select an option:", ["View my account information", "Update name", "Update email", "Update password", "Update genre", "Update website URL", "Delete account", "Go back"]) # prompt allows user to select contact details to edit
   if response == "View my account information"
      puts "Name => #{user.name}".colorize(:cyan)
      puts "Email => #{user.email}".colorize(:cyan)
      puts "Password => #{user.password}".colorize(:cyan)
      puts "Genre => #{user.genre}".colorize(:cyan)
      puts "Website => #{user.website_url}".colorize(:cyan)
      update_artist_account(user)
   elsif response == "Update name"
      new_name = prompt.ask("Please enter your name".colorize(:magenta))
      user.update_name(new_name)
      update_artist_account(user)
   elsif response == "Update email"
      new_email = prompt.ask("Please enter your email address:".colorize(:magenta)){|q| q.validate :email}
      user.update_email(new_email) # Activates method in user class
      update_artist_account(user)
   elsif response == "Update password" # allows to view and change password
      new_pass = prompt.ask("Please provide a new password:".colorize(:magenta))
      user.update_password(new_pass)
      update_artist_account(user)
   elsif response == "Update genre"
      new_genre = prompt.ask("Please enter a new genre:".colorize(:magenta))
      user.update_genre(new_genre) # Activates method in user class
      update_artist_account(user)
   elsif response == "Update website URL"
      new_site = prompt.ask("Please enter a valid URL:".colorize(:magenta))
      user.update_website(new_site)
      update_artist_account(user)
   elsif response == "Delete account"
      delete = prompt.select("Are you sure you want to delete your accout? (This action cannot be undone)".colorize(:yellow), %w[Yes No])
      if delete == "Yes"
         user.destroy
         puts "Your account has been deleted. Thank you for using Mus.ic, we're sorry to see you go!".colorize(:green)
         exit
      elsif delete == "No"
         update_artist_account(user)
      end
   elsif response == "Go back"
      artist_portal(user)
   end
end

def new_gig(user)
   prompt = TTY::Prompt.new
   venues = Venue.all.map(&:name)
   inputs = prompt.collect do
      key(:name).ask("Please enter the concert's name:".colorize(:magenta))
      key(:date).ask("Please confirm the date of the concert:".colorize(:magenta))
      key(:venue).select("Please confirm the venue for the concert:".colorize(:magenta), venues)
      key(:price).ask("Please set a standard price for tickets:".colorize(:magenta))
   end
   user.new_concert(inputs)
   # binding.pry
   artist_portal(user)
end

# VENUE

def update_venue_account(user)
   prompt = TTY::Prompt.new
   response = prompt.select("Please select an option:", ["View my account information", "Update name", "Update email", "Update password", "Update location", "Update website URL", "Update facilities", "Delete account", "Go back"]) 
   if response == "View my account information"
      puts "Name => #{user.name}".colorize(:magenta)
      puts "Email => #{user.email}".colorize(:magenta)
      puts "Password => #{user.password}".colorize(:magenta)
      puts "location => #{user.location}".colorize(:magenta)
      puts "Website => #{user.website_url}".colorize(:magenta)
      puts "Facilities => #{user.facilities}".colorize(:magenta)
      update_venue_account(user)
   elsif response == "Update name"
      new_name = prompt.ask("Please enter the venue's name".colorize(:cyan))
      user.update_name(new_name)
      update_venue_account(user)
   elsif response == "Update email"
      new_email = prompt.ask("Please enter a valid email address:".colorize(:cyan)){|q| q.validate :email}
      user.update_email(new_email) 
      update_venue_account(user)
   elsif response == "Update password" 
      new_pass = prompt.ask("Please provide a new password:".colorize(:cyan))
      user.update_password(new_pass)
      update_venue_account(user)
   elsif response == "Update location"
      new_genre = prompt.ask("Please enter the venue's location:".colorize(:cyan))
      user.update_location(new_genre) 
      update_venue_account(user)
   elsif response == "Update website URL"
      new_site = prompt.ask("Please enter a valid URL:".colorize(:cyan))
      user.update_website(new_site)
      update_venue_account(user)
   elsif response == "Update facilities"
      new_facilities = prompt.ask('Please specify the available facilities at the venue:'.colorize(:cyan))
      user.update_facilities(new_facilities)
      update_venue_account(user)
   elsif response == "Delete account"
      delete = prompt.select("Are you sure you want to delete your accout? (This action cannot be undone)".colorize(:yellow), %w[Yes No])
      if delete == "Yes"
         user.destroy
         puts "Your account has been deleted. Thank you for using Mus.ic, we're sorry to see you go!".colorize(:green)
         exit
      elsif delete == "No"
         update_venue_account(user)
      end
   elsif response == "Go back"
   venue_portal(user)
   end
end


 # PORTALS

   def customer_portal(user)
      prompt = TTY::Prompt.new
      choices = ["Review account information", "Manage payment information", "My concerts", "Buy tickets", "Cancel tickets", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "Manage payment information"
         customer_manage_payment_info(user)
      elsif response == "Review account information"
         update_account(user)
      elsif response == "My concerts" 
         user.my_concerts_list
      elsif response == "Buy tickets"
         buy_tickets(user)
      elsif response == "Cancel tickets"
         choices = user.my_concerts.map(&:name) << "Cancel all"
         choices << "Go back"
         cancel = prompt.select("Please confirm which ticket you would like to cancel:".colorize(:cyan), choices)
         if cancel == "Go back"
            customer_portal(user)
         else
            check = prompt.select("Are you sure you want to cancel your tickets?".colorize(:yellow), %w(Yes No))
               if check == "Yes" 
                  if cancel == "Cancel all"
                     user.cancel_all_tickets 
                  else
                     user.cancel_ticket(cancel) # can't get multi select to work
                  end
               elsif check =="No"
                  customer_portal(user)
               end
         end   
      elsif response == "Log out"
         sign_in_or_new
      end
      customer_portal(user)
   end 

   def venue_portal(user)
      prompt = TTY::Prompt.new
      choices = ["Review account information", "View my concerts", "View all artists", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "Review account information"
         update_venue_account(user)
      elsif response == "View my concerts"
         user.my_concerts_list
      elsif response == "View all artists"
         user.my_artists_list
      elsif response == "Log out"
         # exit
         sign_in_or_new
      end
      venue_portal(user)
   end 

   def artist_portal(user)
      prompt = TTY::Prompt.new
      choices = ["Review account information", "My schedule", "Concert status", "Total ticket sales", "My ticket prices", "New concert", "My earnings (concert)", "Cancel concert", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "Review account information"
         update_artist_account(user)
      elsif response == "My schedule"
         user.my_schedule_info
      elsif response == "Concert status"
         concert = prompt.select("Please select a concert:".colorize(:magenta), user.my_schedule.map(&:name), "Go back")
         user.concert_status_from_name(concert)
      elsif response == "Total ticket sales"
         user.total_number_tickets_sold
      elsif response == "My ticket prices"
         concert = prompt.select("Please select a concert:".colorize(:magenta), user.my_schedule.map(&:name)<<"Go back")
         unless concert == "Go back"
            user.list_my_ticket_prices(concert)
         else
            artist_portal(user)
         end
      elsif response == "My earnings (concert)"
         concert = prompt.select("Please select an option:".colorize(:magenta), (user.my_schedule.map(&:name).push("All", "Go back")))
         if concert == "All"
            user.my_total_earnings
         elsif concert == "Go back"
            artist_portal(user)
         else
            user.my_earnings_concert_gbp(concert)
            artist_portal(user)
         end
      elsif response == "New concert"
         new_gig(user)
      elsif response == "Cancel concert"
         call_off = prompt.select("Please select concert to be cancelled:".colorize(:yellow), user.my_schedule.map(&:name) << "Go back")
         unless call_off == "Go back"
            Concert.all.find{|inst| inst.name == call_off}.destroy
         else
            artist_portal(user)
         end
      elsif response == "Log out"
         # exit
         sign_in_or_new
      end
      artist_portal(user)
   end


#CUSTOMER METHODS
   
   def buy_tickets(user) #This is called by customer_portal(). user is a User (customer) object
      prompt = TTY::Prompt.new
      category = prompt.select("Search by:", ["Artist", "Concert", "Venue", "Cancel"])
      if category == "Cancel"
         customer_portal(user)
      else
         events = search(category)
         #returns one concert
         results = []
         events.each{|concert| results << "#{concert.name} | #{concert.artist.name} | #{concert.date} | tickets available: #{concert.tickets_available} | £#{concert.price}"}
         #added concert.tickets available to results
         buy = prompt.select("Please confirm which event you would like to purchase tickets for?".colorize(:magenta), results<<"Cancel")
         if buy == "Cancel"
            buy_tickets(user)
         else
            user.buy_ticket(buy.split(" | ").first)
            buy_tickets(user)
         end
      end
   end

   def search(category) # This is called by buy_tickets(). This will allow users to search by artist, venue and concert and then book tickets according to what's available.
      prompt = TTY::Prompt.new
      search_term = prompt.ask("Search (leave blank for all options):".colorize(:cyan))
      if search_term == nil
         Concert.all
      else
         if category == "Artist"
            list = []
            Artist.all.each do |inst|
               if inst.name.downcase.include? search_term
                  list << inst
               end
            end
            list.map{|inst| inst.my_schedule}.flatten
            #calls the my_schedule method from the artist class
            #returns all gigs for the search term for that artist
         elsif category == "Concert"
            list = []
            Concert.all.each do |inst|
               if inst.name.downcase.include? search_term
                  list << inst
               end
            end
            list
         elsif category == "Venue"
            list = []
            Venue.all.each do |inst|
               if inst.name.downcase.include? search_term
                  list << inst
               end
            end
            list.map{|inst| inst.my_concerts}.flatten
         end
      end
   end

   def update_account(user) # will allow the user to update contact details
      prompt = TTY::Prompt.new
      response = prompt.select("Please select an option:".colorize(:magenta), ["View my account information", "Update name", "Update DOB", "Update email", "Update password", "Delete account", "Go back"]) # prompt allows user to select contact details to edit
      if response == "View my account information"
         puts "Name => #{user.name}"
         puts "DOB => #{user.dob}"
         puts "Email => #{user.email}"
         puts "Password => #{user.password}"
         update_account(user)
      elsif response == "Update name"
         new_name = prompt.ask("Please enter your name".colorize(:cyan))
         user.update_name(new_name)
         update_account(user)
      elsif response == "Update DOB"
         new_dob = prompt.ask("Please enter your DOB".colorize(:cyan))
         user.update_dob(new_dob)
         update_account(user)
      elsif response == "Update email"
         new_email = prompt.ask("Please enter your email address:".colorize(:cyan)){|q| q.validate :email}
         user.update_email(new_email) # Activates method in user class
         update_account(user)
      elsif response == "Update password" # allows to view and change password
         new_pass = prompt.ask("Please provide a new password:".colorize(:cyan))
         user.update_password(new_pass)
         update_account(user)
      elsif response == "Delete account"
         delete = prompt.select("Are you sure you want to delete your accout? (This action cannot be undone)".colorize(:yellow), %w[Yes No])
         if delete == "Yes"
            user.destroy
            puts "Your account has been deleted. Thank you for using Mus.ic, we're sorry to see you go!".colorize(:green)
            exit
         elsif delete == "No"
            update_account(user)
         end
      elsif response == "Go back"
         customer_portal(user)
      end
   end

   def customer_manage_payment_info(user)
      prompt = TTY::Prompt.new
      choices = ["Add card", "Update card details", "Remove card", "Go back"]
      manage_info = prompt.select("Please choose an option:".colorize(:cyan), choices)
      if manage_info == "Add card"
         check_cards(user)
      elsif manage_info == "Update card details"
         cards = [user.card_1_number, user.card_2_number, user.card_3_number, "Cancel"]
         sel_card = prompt.select("Please select a card:".colorize(:cyan), cards) # the card to be updated
         if sel_card == "Cancel"
            customer_manage_payment_info(user)
         else
            new_card = prompt.ask("Please enter new card number:".colorize(:cyan))
            user.update_card_details(new_card, sel_card)
            customer_manage_payment_info(user)
         end
      elsif manage_info == "Remove card"
         cards = [user.card_1_number, user.card_2_number, user.card_3_number, "Cancel"]
         sel_card = prompt.select("Please select a card:".colorize(:cyan), cards)
         if sel_card == "Cancel"
            customer_manage_payment_info(user)
         else
            options = ["Yes", "No"]
            check = prompt.select("Are you sure you want to delete your current card?".colorize(:yellow), options)
            if check == "Yes"
               user.remove_card(sel_card)
            end
         end
         customer_manage_payment_info(user)
      elsif manage_info =="Go back"
         customer_portal(user)
      end   
   end

   def check_cards(user)
      prompt = TTY::Prompt.new
      nums = []
      nums << user.card_1_number 
      nums << user.card_2_number 
      nums << user.card_3_number
      
      if !nums.include?(nil)
         puts "You have too many cards saved. Please remove or upate and existing card.".colorize(:red)
         customer_manage_payment_info(user)
      else
         i = nums.find_index{|inst| inst == nil}
         card_no = prompt.ask("Please enter the card number".colorize(:cyan))
         user.add_card(card_no, i)
      end
      customer_manage_payment_info(user)
   end

end