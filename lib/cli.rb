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

	def sign_in #asks for email, checks against 3 tables for a record. Returns the record as @current_user and launches the correct portal.
		puts "Mus.ic sign in"
		prompt = TTY::Prompt.new
		email_prompt = prompt.ask('Please enter the email address you signed up with', default: ENV['yourname@gmail.com'])

		user_check = User.find_user_by_email(email_prompt)
		artist_check = Artist.find_artist_by_email(email_prompt)
		venue_check = Venue.find_venue_by_email(email_prompt)
      #we could merge these methods and inherit them to self (find_by_email)


		if user_check 
         @current_user = user_check
         customer_portal(@current_user)
		elsif artist_check
			@current_user = artist_check
			artist_portal(@current_user)
		elsif venue_check 
			@current_user = venue_check
			venue_portal(@current_user)
		else
			sign_in
		end
	end

	def new_user_sign_up
      prompt = TTY::Prompt.new
      choices = ["Customer", "Artist", "Venue Manager", "Log out"]
      response = prompt.select("Welcome to Mus.ic! Please let us know which account you would like to create:", choices)

      if response == "Customer"
         result = prompt.collect do
            key(:name).ask('Please enter your name:')
            # key(:dob).ask('Please enter your date of birth ')
            key(:email).ask('Please enter your email:')
            key(:card_number).ask('Please enter your card number:', convert: :int) 
            #crashes if you add text
            key(:password).ask('Please enter a new password:')
         end

         #we need to check if email already exists and divert to log in if appropriate
         @current_user = User.create(result)
         puts "Thank you, #{@current_user.name}. Your account is now created! Welcome to Mus.ic!"
         customer_portal(@current_user)
         

      elsif response == "Artist"
         result = prompt.collect do
            key(:name).ask('Please enter your name:')
         end

         @current_user = Artist.create(result)
         puts "Thank you, #{@current_user.name}. Your account is now created! Welcome to Mus.ic!"
         artist_portal(@current_user)

# t.string "name"
#     t.string "genre"
#     t.string "website_url"
#     t.string "email"
#     t.string "password"


         # Artist.create(new_text)
      elsif response == "Venue Manager"
         # Venue.create(new_text)
      elsif response == "Log out"
         sign_in_or_new
      end

	end
	
	def exit_menu
		puts "Thank you for using mus.ic, Goodbye."
		exit
	end

  # GLOBAL

   
  def check_cards(user)
   prompt = TTY::Prompt.new
   nums = []
   nums << user.card_1_number 
   nums << user.card_2_number 
   nums << user.card_3_number
   
   if !nums.include?(nil)
      puts "You have too many cards saved. Please remove or upate and existing card."
      customer_manage_payment_info(user)
   else
      i = nums.find_index{|inst| inst == nil}
      card_no = prompt.ask("Please enter the card number")
      user.add_card(card_no, i)
   end
end

def update_account(user) # will allow the user to update contact details
   prompt = TTY::Prompt.new
   response = prompt.select("Please select an option:", ["Email", "Password", "Phone", "Go back"]) # prompt allows user to select contact details to edit
   if response == "Email"
      puts user.email
      manage = prompt.select("Please select an option:", ["Change email", "Go back"])
      # binding.pry
      if manage == "Change email" # allows to change email
         new_email = prompt.ask("Please provide new email address:")
         user.update_email(new_email) # Activates method in user class
         update_account(user)
      elsif manage == "Go back"
         update_account(user)
      end
   elsif response == "Password" # allows to view and change password
      manage = prompt.select("Please select an option:", ["View password", "Change password", "Go back"])
      if manage == "View password"
         puts "#{user.password}"
         update_account(user)
      elsif manage == "Change password"
         new_pass = prompt.ask("Please provide a new password:")
         user.update_password(new_pass)
         update_account(user)
      end
   elsif response == "Phone" # will add when we add a column
      puts "Phone number feature not yet available"
      update_account(user)
      #    new_tel = prompt.ask("Please provide new phone number:")
      #    user.update_tel(new_tel)
   end
end

# CUSTOMER

def customer_manage_payment_info(user)
   prompt = TTY::Prompt.new
   choices = ["Add card", "Update card details", "Remove card", "Go back"]
   manage_info = prompt.select("Please choose an option:", choices)
   if manage_info == "Add card"
      check_cards(user)
   elsif manage_info == "Update card details"
      cards = [user.card_1_number, user.card_2_number, user.card_3_number, "Cancel"]
      sel_card = prompt.select("Please select a card:", cards) # the card to be updated
      if sel_card == "Cancel"
         customer_manage_payment_info(user)
      else
      new_card = prompt.ask("Please enter new card number:")
      user.update_card_details(new_card, sel_card)
      end
   elsif manage_info == "Remove card"
      cards = [user.card_1_number, user.card_2_number, user.card_3_number, "Cancel"]
      sel_card = prompt.select("Please select a card:", cards)
      if sel_card == "Cancel"
         customer_manage_payment_info(user)
      else
         options = ["Yes", "No"]
         check = prompt.select("Are you sure you want to delete your current card?", options)
            if check == "Yes"
               user.remove_card(sel_card)
            end
         end
      elsif manage_info =="Go back"
         customer_portal(user)
      end   
end

def search_concerts(term)
   # binding.pry
   Concert.all.find(:all, :conditions => ['name LIKE ?', "%#{term}%"])
end

def buy_tickets(user)
   prompt = TTY::Prompt.new
   search_term = prompt.ask("Search for an upcoming event:")
      events = search_concerts(search_term) # looking to find an entry which has the characters in the search term
      # binding.pry
   buy = prompt.ask("Please confirm which event you would like to purchase tickets for?")
   user.buy_ticket(buy)
end

# PORTALS

def customer_portal(user)
   prompt = TTY::Prompt.new
   choices = ["Update name", "Update dob", "Review account information", "Manage payment information", "My concerts", "Buy tickets", "Cancel tickets", "Log out"]
   response = prompt.select("Please select an option:", choices)
   if response == "Manage payment information"
      customer_manage_payment_info(user)
   elsif response == "Update name"
      new_name = prompt.ask("Please provide your name")
      user.update_name(new_name)
   elsif response == "Update dob"
      new_dob = prompt.ask("Please provide your DOB")
      user.update_dob(new_dob)
   elsif response == "Review account information"
      update_account(user)
   elsif response == "My concerts" 
      user.my_concerts_list
   elsif response == "Buy tickets"
      buy_tickets(user)
   elsif response == "Cancel tickets"
      choices = user.my_concerts.map(&:name) << "Cancel"
      cancel = prompt.select("Please confirm which ticket you would like to cancel:", choices)
      if cancel == "Cancel"
         customer_portal(user)
      else
         check = prompt.select("Are you sure you want to cancel your tickets?", %w(Yes No))
            if check == "Yes"
               user.cancel_ticket(cancel) # can't get multi select to work
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
   choices = ["View my concerts", "View all artists", "Review account information", "Log out"]
   response = prompt.select("Please select an option:", choices)
   if response == "View my concerts"
      user.my_concerts_list
   elsif response == "View all artists"
      user.my_artists_list
   elsif response == "Review account information"
      update_account(user)
   elsif response == "Log out"
      # exit
      sign_in_or_new
   end
   venue_portal(user)
end 

def artist_portal(user)
   prompt = TTY::Prompt.new
   choices = ["My schedule", "Concert tickets sold", "Total ticket sales", "Where am I playing", "My ticket prices", "My earnings (concert)", "Review account information", "Log out"]
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
   elsif response == "Review account information"
      update_account(user)
   elsif response == "Log out"
      # exit
      sign_in_or_new
   end
   artist_portal(user)
end


end
