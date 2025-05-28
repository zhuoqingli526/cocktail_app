# == Schema Information
#
# Table name: ingredient_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class IngredientCategory < ApplicationRecord
  has_many  :ingredients, class_name: "Ingredient", foreign_key: "ingredient_category_id", dependent: :destroy
end
