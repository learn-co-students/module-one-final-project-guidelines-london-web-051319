class User < ActiveRecord::Base
  has_many :articles, through: :favourites
end
