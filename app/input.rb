def input(userid)

    user = Input.new(userid)
    loop do
      #binding.pry
      puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
      user_input = gets.chomp

      case user_input.downcase
      when 'add'
        add_to_fav(user)
      # when 'remove'
      #   remove_fav
      when 'favourites'
        favourites(user)
      when 'curated'
        list_curated_articles
        print_curated_article_overview(user)
      when 'search'
        search(user)
      when 'most liked'
        most_liked
      when 'aiod'
        aiod
      when 'longest'
        longest
      when 'remove'
        remove_fav(user)
      when 'help'
        help
      when 'exit'
        exit
      else
        puts "Please enter a valid command"
        #binding.pry
    end

  end

end
