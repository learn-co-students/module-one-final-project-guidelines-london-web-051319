class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :date
      t.string :overview
      t.boolean :curated
    end
  end
end
