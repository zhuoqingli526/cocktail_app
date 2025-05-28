# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  password               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :send_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many  :receive_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy
  has_many  :likes, class_name: "CocktailLike", foreign_key: "user_id", dependent: :destroy
  has_many  :comments, class_name: "CocktailComment", foreign_key: "user_id", dependent: :destroy
  has_many :leaders, through: :send_follow_requests, source: :recipient
  has_many :followers, through: :receive_follow_requests, source: :sender
  has_many :liked_cocktails, through: :likes, source: :cocktail
  has_many :commented_cocktails, through: :comments, source: :cocktail
end
