# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  likes_count    :integer
#  picture        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  #belongs_to :user
  belongs_to(:user, { :class_name => "User", :foreign_key => "owner_id" })
  
  has_many :likes

  has_many :comments

  has_many(:fans, { :through => :likes, :source => :user })

  mount_uploader :picture, PictureUploader
  
end
