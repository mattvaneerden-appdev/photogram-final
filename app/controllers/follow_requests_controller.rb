class FollowRequestsController < ApplicationController

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = session[:user_id]

      if the_follow_request.followie.private
         the_follow_request.status = "pending"
      else
         the_follow_request.status = "accepted"
      end

    if the_follow_request.valid?
      the_follow_request.save
      
      redirect_to("/users", { :notice => "You're not authorized for that." })
    else
      redirect_to("/users", { :notice => "Follow request failed to create successfully." })
    end
  end

  def accept
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.status = params.fetch("query_status")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => "Follow request failed to update successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/users/#{the_follow_request.followie.username}", { :notice => "Follow request #{the_follow_request.status} successfully."} )
    else
      redirect_to("/users/#{the_follow_request.followie.username}", { :notice => "Follow request failed to update successfully."} )
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/users", { :notice => "Follow request deleted successfully."} )
  end

end
