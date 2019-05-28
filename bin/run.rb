#!/usr/bin/env ruby
require_relative '../config/environment.rb'

#binding.pry

# list_curated_articles
# print_curated_article_overview
#longest
# largest = most_liked_num
# id = most_liked_id(largest)
# most_liked(id)
# aiod

        puts "Welcome SpaceTraveller! Please enter your username:"
        username = gets.chomp
        user = User.find_by(username: username)

        if !user
           user = User.create(username: username)
        end

        #binding.pry
        # puts "Hello, #{user.username}! What's your current location?"
        # user_location = gets.chomp
        #     #if provided then use
        #     #else obtain location from the browser

        # puts "Here are some objects you can observe from #{user_location}. Please enter a command or alternatively use the 'help' keyword for all options."
        # top_5_for_current_location(user_location)


        input(user.id)




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
