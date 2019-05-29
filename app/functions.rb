# CURATED
def print_curated_article_overview(user)
  puts "\n\n"

  articles = Article.where(curated: true)
  curated_overview = []
  articles.each {|article| curated_overview << "#{article.overview}"}
  puts "\n"
    puts "-- Choose the article that you would like to read by typing its number --"
    puts "\n"
   article_number = gets.chomp.to_i - 1
   article = articles[article_number]
   user.article_id = article.id
   puts "\n"
   puts article.overview
   puts "\n"
end

def list_curated_articles
  articles = Article.where(curated: true)
  curated_titles = []
  articles.each_with_index {|article, index| curated_titles << "#{index+1}. #{article.title}"}
  puts "\n"
  puts "-- C U R A T E D  A R T I C L E S --"
  puts "====================================\n\n"
  curated_titles.each do |title|
    ind = curated_titles.index(title)
    print "#{title}\n\n"
  end
end


# LONGEST OVERVIEW
def longest_article(user)
  
  nums = []
  Article.all.each {|article| nums << article.overview.length}
  largest = nums.sort.last

  article = Article.all.find {|article| article.overview.length == largest}
  puts "\n"
  puts "-- L O N G E S T  A R T I C L E --"
  puts "==================================\n\n"
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n","")

  user.article_id = article.id
  puts "\n"
end


# MOST LIKED
def most_liked_num
  nums = []

  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    nums << len
  end

  nums.sort.last
end

def most_liked_id(most_liked_num)
  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    if len == most_liked_num
      return article.id
    end
  end
end

def most_liked_article(most_liked_id)
  article = Article.find_by(id: most_liked_id)
  print_most_liked_overview(article)
end

def print_most_liked_overview(article)
  puts "\n"
  puts "-- M O S T  L I K E D  A R T I C L E --"
  puts "=======================================\n\n"
  puts "\n"
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n", "")
  puts "\n"
end

# Astronomy Info of the Day
def aiod(user)
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)

  json = JSON.parse(data)

  puts "\n"
  puts "-- A S T R O N O M Y  I N F O  O F  T H E  D A Y --"
  puts "===================================================\n\n"

  puts "
    TITLE: #{json["title"].upcase!}'\n
    DATE: #{json["date"]}'\n
    OVERVIEW: \n\n #{json["explanation"]}\n
  "
  
  new_article = Article.create(title: json["title"], date: json["date"], overview: json["explanation"], curated: false)

  user.article_id = new_article.id
  puts "\n"
end

def add_to_fav(user)
  article_id = user.article_id
  user_id = user.user_id

  user_liked = Favourite.all.find {|fav| fav.article_id == article_id && fav.user_id == user_id}

  #binding.pry
  if !user_liked && article_id
    Favourite.create(article_id: user.article_id, user_id: user.user_id)
    puts "\n"
    puts "-- Added to your favourites --"
    puts "\n"
    input(user_id)
  elsif !article_id
    puts "Cannot Add This Article"
  else
    puts "\n"
    puts "-- This is already in your collections of favourites --"
    puts "\n"
    input(user_id)
  end
end

def remove_fav(user)
  article_id = user.article_id
  user_id = user.user_id
  puts "\n"
  puts "-- Are you sure you want to remove this article from your favourites? (yes/no) --"
  puts "\n"
  input = gets.chomp

  loop do
    if input == "yes"
      fav = Favourite.find_by(article_id: article_id, user_id: user_id)
      fav.destroy
      puts "\n"
      puts "-- Article removed from favourites --"
      puts "\n"
      input(user_id)
    elsif input == "no"
      puts "\n"
      puts "-- Article not removed from favourites --"
      puts "\n"
      input(user_id)
    elsif input == "exit"
      input(user_id)
    else
      puts "\n"
      puts "-- Enter valid command or type exit to close --"
      puts "\n"
      input = gets.chomp
    end
  end
end

def search(user)
  puts "\n"
  puts "-- Please enter the name of the object you would like to read about. --"
  puts "\n"
  searched_name = gets.chomp
  puts "\n"
  searched_name.downcase!
  # num1 = rand(1..10) * rand(10)
  # num2 = num1 + 10

  articles = Article.all.select {|article| article.title.downcase.index(searched_name) } 

  puts "\n"
  articles.each_with_index do |article, index|
    puts "#{index+1}. #{article.title.upcase}\n\n"
  end
  puts "\n"
  puts "-- Choose the article that you would like to read by typing its number --"
  puts "\n"
    article_number = gets.chomp.to_i - 1
    article = articles[article_number]

    puts "\n\n"
    puts article.title
    puts "\n"
    puts article.overview
    puts "\n"
    user.article_id = article.id
end


def favourites(user)
  user_id = user.user_id
  list = Favourite.all.select {|fav| fav.user_id == user_id}
  #binding.pry
  article_arr = list.map {|fav| Article.find_by(id: fav.article_id)}
  #article_arr.pop # get rid of nil value
  #binding.pry

  puts "\n"
  puts "-- F A V O U R I T E  A R T I C L E S --"
  puts "========================================\n\n"

  article_arr.each_with_index {|article, index| puts "#{index+1}. #{article.title}\n\n"}
    puts "\n"
    puts "-- Choose the article that you would like to read by typing its number --"
    puts "\n"
    article_number = gets.chomp.to_i - 1
    article = article_arr[article_number]
    user.article_id = article.id
    puts "\n"
    puts article.overview
    puts "\n"
end

def help
  puts "\n"
  puts "|'search' - gives the option to search through all articles"
  puts "\n"
  puts "|'add' - adds the selected article to the user's favourites list"
  puts "\n"
  puts "|'remove' - removes the selected article from the user's favourites list"
  puts "\n"
  puts "|'favourites' - user's current list of favourite articles"
  puts "\n"
  puts "|'curated' - lists a number of curated articles"
  puts "\n"
  puts "|'aiod' - pulls an article from NASA's Astronomy Photo of the Day website about the featured photo"
  puts "\n"
  puts "|'most liked' - prints out the article with the most entries in all users' favourites lists"
  puts "\n"
  puts "|'longest' - prints out the article with the longest description"
  puts "\n"
  puts "|'exit' - terminates the app"
  puts "\n"
end



# TODO"'my location is ...' - changes your curent location to a new entry"\n
# TODO"'from my location' - prints the top 5 objects visible from the choosen location"n
