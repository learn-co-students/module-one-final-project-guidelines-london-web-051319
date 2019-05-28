class Favourite < ActiveRecord::Base
  belongs_to :user, foreign_key: true
  belongs_to :article, foreign_key: true
end
