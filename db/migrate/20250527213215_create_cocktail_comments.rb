class CreateCocktailComments < ActiveRecord::Migration[7.1]
  def change
    create_table :cocktail_comments do |t|
      t.integer :cocktail_id
      t.integer :user_id

      t.timestamps
    end
  end
end
