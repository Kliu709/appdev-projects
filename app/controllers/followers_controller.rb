class FollowersController < ApplicationController
  def index
    matching_followers = Follower.all

    @list_of_followers = matching_followers.order({ :created_at => :desc })

    render({ :template => "followers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_followers = Follower.where({ :id => the_id })

    @the_follower = matching_followers.at(0)

    render({ :template => "followers/show.html.erb" })
  end

  def create
    the_follower = Follower.new
    the_follower.sender_id = params.fetch("query_sender_id")
    the_follower.recipient_id = params.fetch("query_recipient_id")

    if the_follower.valid?
      the_follower.save
      redirect_to("/followers", { :notice => "Follower created successfully." })
    else
      redirect_to("/followers", { :notice => "Follower failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follower = Follower.where({ :id => the_id }).at(0)

    the_follower.sender_id = params.fetch("query_sender_id")
    the_follower.recipient_id = params.fetch("query_recipient_id")

    if the_follower.valid?
      the_follower.save
      redirect_to("/followers/#{the_follower.id}", { :notice => "Follower updated successfully."} )
    else
      redirect_to("/followers/#{the_follower.id}", { :alert => "Follower failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follower = Follower.where({ :id => the_id }).at(0)

    the_follower.destroy

    redirect_to("/followers", { :notice => "Follower deleted successfully."} )
  end
end
