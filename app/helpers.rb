# USER UPDATE

def print_user_taken
  puts "\n"
  puts "-- This name is taken. Please choose another name. --"
  puts "\n"
  puts "-- Press Enter For Main Menu --"
  puts "\n"
end

def print_user_saved(inp)
  puts "\n"
  puts "-- Your new name is #{inp} --"
  puts "\n"
  puts "-- Press Enter For Main Menu --"
  puts "\n"
end

def save_user(user, inp)
  current_user = User.find_by(id: user.user_id)
  current_user.username = inp
  current_user.save
  print_user_saved(inp)
end

# CURATED ARTICLES
def print_curated_heading_and_titles(arr)
  puts "\n"
  puts "-- C U R A T E D  A R T I C L E S --"
  puts "====================================\n\n"

  arr.each do |title|
    print "#{title}\n\n"
  end
end

def print_longest_article_heading
  puts "\n"
  puts "-- L O N G E S T  A R T I C L E --"
  puts "==================================\n\n"
end

def print_article(article)
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n","")
  puts "\n"
  puts "Press Enter For Main Menu"
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

def print_most_liked_heading
  puts "\n"
  puts "-- M O S T  L I K E D  A R T I C L E --"
  puts "=======================================\n\n"
  puts "\n"
end

# Astro Info
def print_aiod_heading
  puts "\n"
  puts "-- A S T R O N O M Y  I N F O  O F  T H E  D A Y --"
  puts "===================================================\n\n"
end

def print_aiod_article(title, date, overview)
  puts "
    TITLE: #{title.upcase!}'\n
    DATE: #{date}'\n
    OVERVIEW: \n\n #{overview}\n
  "
end

def parse_aiod_url
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)
  return JSON.parse(data)
end

def aiod_check_add_to_db(article, json, user)
  if !article
    new_article = Article.create(title: json["title"], date: json["date"], overview: json["explanation"], curated: false)
    user.article_id = new_article.id
    puts "\n"
  end
end

#
