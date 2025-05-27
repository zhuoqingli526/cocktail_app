# == Schema Information
#
# Table name: cocktail_comments
#
#  id           :bigint           not null, primary key
#  comment_text :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cocktail_id  :integer
#  user_id      :integer
#
class CocktailComment < ApplicationRecord
end
