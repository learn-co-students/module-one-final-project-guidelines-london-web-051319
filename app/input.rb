def input(userid)
    puts "\n"
    puts "-- Please enter a valid command or alternatively use the 'help' keyword for all options. --"
    puts "\n"
    user = Input.new(userid)
    loop do
      #binding.pry

      user_input = gets.chomp

      case user_input.downcase
      when '2'
        add_to_fav(user)
      when '3'
        remove_fav(user)
      when '4'
        favourites(user)
      when '8'
        list_curated_articles
        print_curated_article_overview(user)
      when '1'
        search(user)
      when '6'
        id = most_liked_id(most_liked_num)
        most_liked_article(id)
      when '5'
        aiod(user)
      when '7'
        longest_article(user)
      when 'help'
        help
      when '0'
        exit
      else
        puts "-- Please enter a valid command or alternatively use the 'help' keyword for all options. --"
        #binding.pry
    end

  end

end
