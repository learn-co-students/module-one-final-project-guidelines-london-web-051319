#require "pry"

def search
    puts "Please enter an object's name:"
    searched_name = gets.chomp
    searched_name.downcase
    # searched_article = Article.all.select {|article| article.title.downcase.include?(searched_name)}
    # searched_article.map {|article| article.overview}
    searched_article = Article.all.select {|article| article.title.downcase.include?(searched_name)}.map {|article| article.overview}
    puts "How many articles would you like to read for the #{searched_name}?"
    number_of_articles = gets.chomp.to_i - 1
    searched_article[0..number_of_articles].each_with_index do |article, index| 
        puts "#{index + 1}. #{article}"
        puts "\n"
    end
end

def add
    puts "Please enter an object's name:"
    searched_name = gets.chomp
    searched_name.downcase
    if user_id = nil && article_id = nil
        puts "There is no article selected. Please first select an article and then try to add it to your Favourites list."
    else
    new_favourite = Favourite.new(user_id, article_id)
    new_favourite.save
    end
end

def remove(favourite_id)
    sql = <<-SQL 
    DELETE FROM favourites 
    WHERE id = ?; 
    SQL
    db.execute(sql, favourites_id)
end

def favourites
    sql = <<-SQL 
    SELECT * 
    FROM favourites;
    SQL
    db.execute(sql)
end

def total
    sql = <<-SQL 
    SELECT COUNT(*) 
    FROM articles;
    SQL
    db.execute(sql)
end

def help
    puts "'search' - give the option to search"
    puts "'add' - adds the object to the user's favourites list"
    puts "'remove' - removes the object from the user's favourites list"
    puts "'favourites' - user's current list of favourites"
    puts "'curated_articles' - lists a number of curated articles"
    puts "'total' - a full list of objects in the database"
    puts "'most liked' - prints out the object with the most entries in all users' favourites lists"
    puts "'best known' - prints out the object with the longest description"
    puts "'exit' - terminates the app"
end

# def top_5_for_current_location(user_location)
#     sql = <<-SQL
#             SELECT *
#             FROM articles
#             WHERE location == user_location
#             LIMIT 5;
#             SQL
#     DB[:conn].execute(sql)
# end

def input
    loop do 
        user_input = gets.chomp
        case user_input.downcase
        when 'add'
            add
        when 'remove'
            remove
        when 'favourites'
            favourites
        when 'total'
            total
        when 'categories'
            categories
        when 'search'
            search
        when 'most liked'
            most_liked
        when 'best known'
            best_known
        when 'help'
            help
        when 'exit'
            exit
        else
            puts "Please enter a valid command"
    end
end



end

# TODO"'my location is ...' - changes your curent location to a new entry"\n
# TODO"'from my location' - prints the top 5 objects visible from the choosen location"n