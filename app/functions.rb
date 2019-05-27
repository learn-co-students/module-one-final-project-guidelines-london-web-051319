# CURATED
def print_curated_article_overview
  puts "\n\n"
  puts "\nSelect article by typing its title"

  articles = Article.where(curated: true)
  curated_titles = []
  articles.each {|article| curated_titles << "#{article.title}"}
  usr_input = gets.chomp
  obj = articles.find {|article| article.title.downcase == usr_input.downcase }

  #binding.pry
  if obj.title.downcase == usr_input.downcase
    puts "\n\n"
    puts obj.title.upcase
    puts "\n"
    puts obj.overview.gsub("\n", "")
  else
    puts "Select article by typing its title"
    usr_input = gets.chomp
  end
end

def list_curated_articles
  articles = Article.where(curated: true)
  curated_titles = []
  articles.each_with_index {|article, index| curated_titles << "#{index+1}. #{article.title}"}

  puts "C U R A T E D  A R T I C L E S"
  puts "==============================\n\n"
  curated_titles.each do |title|
    ind = curated_titles.index(title)
    if ind % 3 == 0
      print "\n\n#{title}"
    else
      print "  #{title}"
    end
  end
end


# LONGEST OVERVIEW
def longest
  nums = []
  Article.all.each {|article| nums << article.overview.length}
  largest = nums.sort.last

  article = Article.all.find {|article| article.overview.length == largest}

  puts article.title.upcase
  puts "\n\n"
  puts article.overview.gsub("\n","")
end


# MOST LIKED
def most_liked
  nums = []

  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    nums << len
  end

  largest = nums.sort.last
  most_liked_id = []

  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    if len == largest
      most_liked_id << article.id
    end
  end

  article = Article.find_by(id: most_liked_id[0])
  puts "\n\n"
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n", "")
  puts "\n"
end

# "'add' - adds the object to the user's favourites list"\n
# "'remove' - removes the object from the user's favourites list"\n
# 'favourites' - user's current list of favourites"\n


# Astronomy Info of the Day
def aiod
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)

  json = JSON.parse(data)

  puts "
    #{json["title"].upcase!}'\n
    #{json["date"]}'\n
    #{json["explanation"]}
  "
end

def add(article_id, user_id)
  user_liked = Favourite.where(article_id: article_id, user_id: user_id)

  if user_liked
    puts "This is already in your collections of favourites"
  else
    Favourite.create(article_id: article_id, user_id: user_id)
    puts "Added to your favourites"
  end
end

def remove(article_id, user_id)
  puts "Are you sure you want to remove this article from your favourites? (y/n)"
  input = gets.chomp

  if input == "y"
    Favourite.find_by(article_id: article_id, user_id: user_id).destroy_all
  else
    puts "Article not removed from favourites"
  end
end
