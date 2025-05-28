# == Schema Information
#
# Table name: cocktails
#
#  id            :bigint           not null, primary key
#  abv           :string
#  cocktail_name :string
#  description   :string
#  image_url     :string
#  instructions  :string
#  taste         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Cocktail < ApplicationRecord
  mount_uploader :image_url, ImageUploader

  has_many  :likes, class_name: "CocktailLike", foreign_key: "cocktail_id", dependent: :destroy
  has_many  :comments, class_name: "CocktailComment", foreign_key: "cocktail_id", dependent: :destroy
  has_many  :cocktail_ingredients, class_name: "CocktailIngredient", foreign_key: "cocktail_id", dependent: :destroy
  has_many :votes, through: :likes, source: :user
  has_many :commenters, through: :comments, source: :user
  has_many :commenters, through: :comments, source: :user
end
