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
end
