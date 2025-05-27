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
end
