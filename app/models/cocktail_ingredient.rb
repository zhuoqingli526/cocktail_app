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
end
