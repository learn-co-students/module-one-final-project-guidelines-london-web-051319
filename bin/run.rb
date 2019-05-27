 require_relative '../config/environment'

        puts "Welcome SpaceTraveller! Please enter your username:"
        user = gets.chomp
        if User.all.include? user
            user = User.find_by(username: user)
        else
            user = User.create(username: user)
        end
        # puts "Hello, #{user.username}! What's your current location?"
        # user_location = gets.chomp
        #     #if provided then use 
        #     #else obtain location from the browser

        # puts "Here are some objects you can observe from #{user_location}. Please enter a command or alternatively use the 'help' keyword for all options."
        # top_5_for_current_location(user_location)

        puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
        input




 
#3. Here are some objects you can observe from {#location}. For the full list of available objects in our database type ??? and hit enter. Or alternatively use the "help" command for all options.
    #prints 5 objects based on location

#4. What object would you like to explore? You can search by name, category and location from which it could be seen at the moment.
    #gets user entry and prnts relevant object/s

#4. You have chosen {#choosen object}. Here is some info about it.
    #prints objects description
    #prints link to an online article/photo

#5. Would you like to add {#choosen object} to your favourites list?
    #yes - add to list
    #no - prints 5 RANDOM obejcts with the text "Here are a few other objects you might be interested in"

#6. You have chosen to check you own collection of favoutrite objects. Here is your list:
    #lists all favourite objects

#7. You have selected {#fav. object}. What would you like to do? Type "info" to get a full description or "remove" to delete it from your list.
