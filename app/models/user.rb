# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  avatar_image :string
#  bio          :string
#  email        :string
#  password     :string
#  username     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class User < ApplicationRecord
  has_many  :send_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many  :receive_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy
  has_many  :likes, class_name: "CocktailLike", foreign_key: "user_id", dependent: :destroy
  has_many  :comments, class_name: "CocktailComment", foreign_key: "user_id", dependent: :destroy
  has_many :leaders, through: :send_follow_requests, source: :recipient
  has_many :followers, through: :receive_follow_requests, source: :sender
  has_many :liked_cocktails, through: :likes, source: :cocktail
  has_many :commented_cocktails, through: :comments, source: :cocktail
end
