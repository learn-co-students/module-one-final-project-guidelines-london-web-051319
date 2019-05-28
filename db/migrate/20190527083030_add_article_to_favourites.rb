class AddArticleToFavourites < ActiveRecord::Migration[5.0]
  def change
    add_column :favourites, :article_id, :integer
  end
end
