# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  body       :text
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  session_id :string
#
class Message < ApplicationRecord
end
