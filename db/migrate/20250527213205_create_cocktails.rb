class CreateCocktails < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktails do |t|
      t.string :cocktail_name
      t.string :description
      t.string :instructions
      t.string :abv
      t.string :taste
      t.string :image_url
      t.integer :user_id

      t.timestamps
    end
  end
end
