class AddUserToFavourites < ActiveRecord::Migration[5.0]
  def change
    add_column :favourites, :user_id, :integer
  end
end
