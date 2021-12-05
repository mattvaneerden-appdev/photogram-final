# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord

  #def followed
  #  the_id = self.recipient_id
  #  matching_user = User.where({ :id => the_id }).at(0)
  #  return matching_user
  #end

  belongs_to(:followie, { :class_name => "User", :foreign_key => "recipient_id" })
  
  belongs_to(:follower, { :class_name => "User", :foreign_key => "sender_id" })

end
