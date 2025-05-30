class FollowRequestsController < ApplicationController
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show" })
  end

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    redirect_path = params.fetch("redirect_to", "/users/#{the_follow_request.recipient_id}")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to(redirect_path, { :notice => "Followed successfully." })
    else
      redirect_to(redirect_path, { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end



  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)
    recipient_id = the_follow_request.recipient_id
    redirect_path = params.fetch("redirect_to", "/users/#{recipient_id}")

    the_follow_request.destroy
    redirect_to(redirect_path, { :notice => "Unfollowed successfully." })
  end
end
