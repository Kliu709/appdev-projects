class FollowersController < ApplicationController
  def index
    matching_followers = Follower.all

    @list_of_followers = matching_followers.order({ :created_at => :desc })

    render({ :template => "followers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    @the_user = @current_user
    matching_followers = Follower.where({:sender_id => @the_user.id})
    #matching_followers = Follower.where({ :id => the_id })

    @list_of_followers = matching_followers.at(0)
    render({ :template => "followers/show.html.erb" })
  end

  def create
    the_follower = Follower.new
    the_follower.sender_id = @current_user.id 
    the_recipient_username = params.fetch("query_recipient_name")
    the_follower.recipient_id = User.where({:username => the_recipient_username}).first.id
    the_follower.status = false 
    #duplicate = Follower.where({:sender_id => the_follower.sender_id, :recipient_id => the_follower.recipient_id}).first

    #if (duplicate.sender_id == the_follower.sender_id) and (duplicate.recipient_id == the_follower.recipient_id)
     # copy = true
    #end 

    if (the_follower.valid?) 
      the_follower.save
      redirect_to("study_blocks/index.html.erb", { :notice => "Follower created successfully." })
    else
      redirect_to("study_blocks/index.html.erb", { :notice => "Follower failed to create successfully." })
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
