def input(userid)

    article_id = 0
    user = Input.new(userid)
    loop do
        user_input = gets.chomp
      #binding.pry
      puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
      case user_input.downcase
      when 'add'
        add_to_fav(user)
      when 'remove'
        remove_fav
      when 'favourites'
        favourite_articles(user)
      when 'curated'
        list_curated_articles
        print_curated_article_overview(user)
      when 'search'
        search_article
      when 'most liked'
        most_liked
      when 'aiod'
        aiod
      when 'longest'
        longest
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