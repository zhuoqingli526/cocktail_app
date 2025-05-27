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
end
