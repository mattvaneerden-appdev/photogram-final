# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  belongs_to :photo
  
  belongs_to(:user, { :class_name => "User", :foreign_key => "fan_id" })

  #has_many :photos
  #has_many(:pics, { :class_name => "Photo", :foreign_key => "photo_id" })
end
