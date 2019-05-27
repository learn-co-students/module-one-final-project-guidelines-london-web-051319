 require_relative '../config/environment'

        puts "Welcome SpaceTraveller! Please enter your username:"
        user = gets.chomp
        if User.all_users.include? user
            user = User.find_by(name: user)
        else
            user = User.create(name: user)
            user.downcase
        end
        puts "Hello, #{user.name}! What's your current location?"
        location = gets.chomp
            #if provided then use 
            #else obtain location from the browser

        puts "Here are some objects you can observe from #{location}. For the full list of available objects in our database type 'list' and hit enter. Or alternatively use the 'help' command for all options."
        sql = <<-SQL
            
            SQL
        puts "#{sql}."
        loop do
        input = gets.chomp
        input.downcase
        input(input)
        



            puts "Please enter a valid command"
        end




 
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

#help command will return:
    #info - prints all available info for an object
    #add - adds the object to the user's favourites list
    #remove - removes the object from the user's favourites list
    #favourites - user's current list of favourites
    #most liked- prints out the object with the most entries in all users' favourites lists
    #best known- prints out the object with the longest description
    #my location is ... - uses the location name provided
    #from my location - prints the top 5 objects visible from the choosen location
    #categories - lists all categiries of objects
    #list - a full list of object in the database
    #list {#specific category} - lists all objects from the desired category
    #search - brings question number 4
    #exit - terminates the app
