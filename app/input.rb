def input(userid)
    puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
    user = Input.new(userid)
    loop do
      #binding.pry

      user_input = gets.chomp

      case user_input.downcase
      when 'add'
        add_to_fav(user)
      when 'remove'
        remove_fav(user)
      when 'favourites'
        favourites(user)
      when 'curated'
        list_curated_articles
        print_curated_article_overview(user)
      when 'search'
        search(user)
      when 'most liked'
        id = most_liked_id(most_liked_num)
        most_liked_article(id)
      when 'aiod'
        aiod(user)
      when 'longest'
        longest_article
      when 'help'
        help
      when 'exit'
        exit
      else
        puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
        #binding.pry
    end

  end

end
