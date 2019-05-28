require "json"
require "pry"
require "faker"

file = File.read("db/astronomy.json")
json = JSON.parse(file)

# iterate through the categories and push them to the database
json.each do |key, data|
  data.each do |hash|
    title =  hash["title"]
    date =  hash["date"]
    overview =  hash["overview"]
    curated = hash["curated"]
    Article.create(title: title, date: date, overview: overview, curated: curated)
  end
end
# Create 10 Users
10.times { User.create(username: Faker::Name.name) }

Favourite.new(user_id: 1, article_id: 10)
