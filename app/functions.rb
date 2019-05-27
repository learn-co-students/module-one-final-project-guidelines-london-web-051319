require "pry"
# def info
#
#     puts  "'info' - prints all available info for an object"\n
# end
#
# "'add' - adds the object to the user's favourites list"\n
# "'remove' - removes the object from the user's favourites list"\n
# "'favourites' - user's current list of favourites"\n
#
# "'my location is ...' - changes your curent location to a new entry"\n
# "'from my location' - prints the top 5 objects visible from the choosen location"n
#
# "'search' - give the option to search"\n
# "'exit' - terminates the app"\n




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
    len = Favourite.all.select { |fav| fav.article_id == article.id }.size
    num << len
  end

  largest = nums.sort.last

  Article.all.each do |article|
    arr = Favourite.all
  end

  article = Article.find_by(id: most_liked_id.article_id)
  article.overview
end
