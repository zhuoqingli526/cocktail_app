# == Schema Information
#
# Table name: ingredients
#
#  id                     :bigint           not null, primary key
#  abv                    :float
#  description            :string
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  ingredient_category_id :integer
#
class Ingredient < ApplicationRecord
  has_many  :cocktail_ingredients, class_name: "CocktailIngredient", foreign_key: "ingredient_id", dependent: :destroy
  belongs_to :ingredient_category, required: true, class_name: "IngredientCategory", foreign_key: "ingredient_category_id"
  has_many :cocktails, through: :cocktail_ingredients, source: :cocktail
end
