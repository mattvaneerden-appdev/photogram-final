# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:photos, { :class_name => "Photo", :foreign_key => "owner_id" })

  has_many(:inbox, { :class_name => "FollowRequest", :foreign_key => "recipient_id" })
  
  has_many(:sent, { :class_name => "FollowRequest", :foreign_key => "sender_id" })
  
  has_many(:likes, { :class_name => "Like", :foreign_key => "fan_id" })

  has_many(:likedpics, { :through => :likes, :source => :photo })

  def following
    array_of_user_ids = Array.new
    my_reqs = self.sent
    my_reqs.each do |a_req|
      if a_req.status == "accepted"
      array_of_user_ids.push(a_req.recipient_id)
      end
    end

    matching_users = User.where({ :id => array_of_user_ids })
    return matching_users
  end

  #def following
  #  friends = self.sent.where({ :status => "accepted" })
  #  
  #  return friends
  #end

  def feed
    friends = self.following
    the_gram = Photo.where({ :owner_id => friends.ids })
    
    return the_gram.order({ :created_at => :desc })
  end

  def discover
    array_of_photo_ids = Array.new
    friends = self.following
    many_likes = Like.where({ :fan_id => friends.ids })

    many_likes.each do |a_like|
      the_photo = a_like.photo

      array_of_photo_ids.push(the_photo.id)
    end

    matching_photos = Photo.where({ :id => array_of_photo_ids })

    return matching_photos
  end

  has_many(:comments, { :class_name => "Comment", :foreign_key => "author_id" })
end
