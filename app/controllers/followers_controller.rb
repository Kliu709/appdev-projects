class FollowersController < ApplicationController
  def index
    matching_followers = Follower.all

    @list_of_followers = matching_followers.order({ :created_at => :desc })

    render({ :template => "followers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    @the_user = @current_user
    matching_followers = @current_user.received_follow_requests.where({ :status => false})
    #matching_followers = Follower.where({ :id => the_id })

    @list_of_follow_requests = matching_followers

    matching_friends = @current_user.received_follow_requests.where({ :status => true})

    @list_of_friends_received = matching_friends.order({ :created_at => :desc })
    @list_of_friends_sent = @current_user.sent_follow_requests.where({ :status => true})
    render({ :template => "followers/show.html.erb" })
  end

  def create
    the_follower = Follower.new
    the_follower.sender_id = @current_user.id 
    the_recipient_username = params.fetch("query_recipient_name")
    the_follower.recipient_id = User.where({:username => the_recipient_username}).first.id
    the_follower.status = false 

    
    #@real_follower = the_follower 
    #duplicate = Follower.where({:sender_id => the_follower.sender_id, :recipient_id => the_follower.recipient_id}).first

    #if (duplicate.sender_id == the_follower.sender_id) and (duplicate.recipient_id == the_follower.recipient_id)
     # copy = true
    #end 
    existing_copy = Follower.where({:sender_id => the_follower.recipient_id, :recipient_id => the_follower.sender_id}).first
    if (the_follower.sender_id == the_follower.recipient_id)
      redirect_to("/followers/#{@current_user.id}", { :notice => "Can't friend yourself" })
    elsif (existing_copy != nil)
      redirect_to("/followers/#{@current_user.id}", { :notice => "Request already sent!" })
    elsif (the_follower.valid?) 
      the_follower.save
      redirect_to("/followers/#{@current_user.id}", { :notice => "Friend request sent!" })
    else
      redirect_to("/followers/#{@current_user.id}", { :notice => "Friend request failed to create successfully." })
    end

  end

  def update
    the_id = params.fetch("path_id")
    the_follower = Follower.where({ :sender_id => the_id }).at(0)
    status = params.fetch("query_status")
    #the_follower.sender_id = params.fetch("query_sender_id")
    #the_follower.recipient_id = @current_user.id
    the_follower.status = status

    if the_follower.valid?
      the_follower.save
      redirect_to("/followers/#{the_follower.id}", { :notice => "Follower updated successfully."} )
    else
      redirect_to("/followers/#{the_follower.id}", { :alert => "Follower failed to update successfully." })
    end
  end

  def destroy
    friend_entry_id = params.fetch("path_id")
    the_follower = Follower.where({ :id => friend_entry_id }).at(0) #find the entry where the friendship is stored
    #desired_record = the_follower.recipient_id 
    #the_real_follower = Follower.where({:sender_id => desired_record}).first

    the_follower.destroy

    #if i have 2 friends, they share one follower record
    #if one of the friends deletes a follower record, I should delete the record for both friends
    #ex. if alice is the sender, and bob is the recipient
    #alice deletes, then we look at the record check if alice is recipient or sender 
    redirect_to("/followers/#{@current_user.id}", { :notice => "Follower deleted successfully."} )
  end
end
