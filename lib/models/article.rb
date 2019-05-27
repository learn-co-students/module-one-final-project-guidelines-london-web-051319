class Article < ActiveRecord::Base
  has_many :users, through: :favourites
end
