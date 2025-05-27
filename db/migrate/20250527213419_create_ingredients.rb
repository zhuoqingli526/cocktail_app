class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :description
      t.float :abv
      t.integer :ingredient_category_id

      t.timestamps
    end
  end
end
