# == Schema Information
#
# Table name: cocktail_ingredients
#
#  id            :bigint           not null, primary key
#  unit_ml       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cocktail_id   :integer
#  ingredient_id :integer
#
class CocktailIngredient < ApplicationRecord
  belongs_to :cocktail, required: true, class_name: "Cocktail", foreign_key: "cocktail_id"
  belongs_to :ingredient, required: true, class_name: "Ingredient", foreign_key: "ingredient_id"
end
