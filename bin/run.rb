#!/usr/bin/env ruby
require_relative '../config/environment.rb'

      puts "\n"
        puts "-- Welcome SpaceTraveller! Please enter your username:-- "
        puts "\n"
        username = gets.chomp
        user = User.find_by(username: username)

        if !user
           user = User.create(username: username)
        end
        puts "\n"
        puts "-- Hello, #{username}! --"
        user_obj = Input.new(user.id)
        input(user_obj)
