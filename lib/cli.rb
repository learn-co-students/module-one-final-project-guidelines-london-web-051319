require "pry"

class Cli 
	def run # this will be the first method called by run.rb
		welcome_message
		sign_in_or_new
	end

	def welcome_message # outputs big mus.ic welcome screen.
		font = TTY::Font.new(:doom)
		pastel = Pastel.new
		puts pastel.red.on_yellow.bold(font.write("Mus.ic"))
		
	end

	def sign_in_or_new 	# appears at startup, gives the user 3 initial choices that call the methods below.
		puts "Hello! Welcome to Mus.ic"
		prompt = TTY::Prompt.new
		choices = ["Sign In", "New User", "Exit"]
		response = prompt.select("Please select an option:", choices)
			if response == "Sign In"
				sign_in
			elsif response == "New User"
				new_user_sign_up
			elsif response == "Exit"
				exit_menu
			end
	end

	def sign_in
		puts "Mus.ic sign in"
		prompt = TTY::Prompt.new
		email = prompt.ask('Please enter the email address you signed up with', default: ENV['yourname@gmail.com'])
		
		# email_check = User.find_user_by_email(email) #this is working :-) tomorrow i'll continue on the log in/ sign up methods
      # # binding.pry 

      #We could actually just do an && condition where they only get through if the username and password match our records. Also going through each list actually worked pretty well. 
      if User.all.map(&:email).include?(email)
         customer_portal(email)
      elsif Venue.all.map(&:email).include?(email)
         venue_portal(email)
      elsif Artist.all.map(&:email).include?(email)
         artist_portal(email)
      end
	end

	def new_user_sign_up
		puts "this is the user sign up method"
	end
	
	def exit_menu
		puts "Thank you for using mus.ic, Goodbye."
		exit
	end

   # ARTISTS

   def customer_portal(email_add)
      user = User.all.select{|inst| inst.email == email_add}.first
      # binding.pry
      prompt = TTY::Prompt.new
      choices = ["Add Card", "Update name", "Update dob", "Update card details", "Remove card", "My concerts", "Buy ticket", "Cancel ticket", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "Add card"
         card_no = prompt.ask("Please enter the card number")
         user.add_card(card_no)
      elsif response == "Update name"
         new_name = prompt.ask("Please provide your name")
         user.update_name(new_name)
      elsif response == "Update dob"
         new_dob = prompt.ask("Please provide your DOB")
         user.update_dob(new_dob)
      elsif response == "Update card details" 
         new_card = prompt.ask("Please provide your card details")
         user.update_card_details(new_card)
      elsif response == "Remove card" 
         options = ["Yes", "No"]
         check = prompt.ask("Are you sure you want to delete your current card?", options)
         if check == "Yes"
            user.remove_card
         end
      elsif response == "My concerts" 
         user.my_concerts_list
      elsif response == "Buy ticket"
         buy = prompt.ask("Please confirm which event you would like to purchase tickets for?")
         user.buy_ticket(buy)
      elsif response == "Cancel ticket"
         cancel = prompt.ask("Please confirm which tickets you would like to cancel?")
         options = ["Yes", "No"]
         check = prompt.ask("Are you sure you want to cancel your tickets?", options)
         if check == "Yes"
            user.cancel_ticket(cancel)
         end
      elsif response == "Log out"
         exit
      end
      customer_portal(email_add)
   end 

   def venue_portal(email_add)
      user = Venue.all.find{|inst| inst.email == email_add}
      prompt = TTY::Prompt.new
      choices = ["View my concerts", "View all artists", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "View my concerts"
         user.my_concerts_list
      elsif response == "View all artists"
         user.my_artists_list
      elsif response == "Log out"
         exit
      end
      venue_portal(email_add)
   end 

   def artist_portal(email_add)
      user = Artist.all.find{|inst| inst.email == email_add}
      # binding.pry
      prompt = TTY::Prompt.new
      choices = ["My schedule", "Concert tickets sold", "Total ticket sales", "Where am I playing", "My ticket prices", "My earnings (concert)", "Log out"]
      response = prompt.select("Please select an option:", choices)
      if response == "My schedule"
         user.my_schedule_info
      elsif response == "Concert tickets sold"
         concert = prompt.ask("Please specify a concert")
         user.number_tickets_sold_concert(concert)
      elsif response == "Total ticket sales"
         user.total_number_tickets_sold
      elsif response == "Where am I playing"
         user.where_am_i_playing
      elsif response == "My ticket prices"
         concert = prompt.ask("Please specify a concert")
         user.list_my_ticket_prices(concert)
      elsif response == "My earnings (concert)"
         concert = prompt.ask("Please specify a concert")
         user.my_earnings_concert_gbp(concert)
      elsif response == "Log out"
         exit
      end
      artist_portal(email_add)
   end 



end












