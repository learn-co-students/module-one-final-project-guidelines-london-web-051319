#!/usr/bin/env ruby
require_relative '../config/environment.rb'


        puts "Welcome SpaceTraveller! Please enter your username:"
        username = gets.chomp
        user = User.find_by(username: username)

        if !user
           user = User.create(username: username)
        end

        input(user.id)
