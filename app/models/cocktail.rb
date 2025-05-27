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
end
