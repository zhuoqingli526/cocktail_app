# == Schema Information
#
# Table name: cocktail_likes
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cocktail_id :integer
#  user_id     :integer
#
class CocktailLike < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :cocktail, required: true, class_name: "Cocktail", foreign_key: "cocktail_id"
end
