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
		
		email_check = User.find_user_by_email(email) #this is working :-) tomorrow i'll continue on the log in/ sign up methods
		# binding.pry 
	end

	def new_user_sign_up
		puts "this is the user sign up method"
	end
	
	def exit_menu
		puts "Thank you for using mus.ic, Goodbye."
		exit
	end

   # ARTISTS

   # binding.pry

   def customer_options
   		user_x = User.all[0] #James, i think this is working! we were looking at an old file.... Chris.
      prompt = TTY::Prompt.new
      choices = %w(add_card, update_name, update_dob, update_card_details, remove_card, my_concerts, buy_ticket, cancel_ticket)
      prompt.enum_select("Please select an option:", choices)
      binding.pry
   end 

   def venue_options
      prompt = TTY::Prompt.new
      choices = %w(my_concerts, my_artists)
      prompt.enum_select("Please select an option:", choices)
   end 

   def artist_options
      prompt = TTY::Prompt.new
      choices = %w(my_schedule, concert_tickets_sold, all_tickets, total_tickets_sold, where_am_i_playing, my_ticket_prices, my_earnings_concert)
      prompt.enum_select("Please select an option:", choices)
   end 



end












