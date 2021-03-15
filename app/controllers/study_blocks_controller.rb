class StudyBlocksController < ApplicationController
  def index
    my_study_blocks = @current_user.study_blocks

    @list_of_study_blocks = my_study_blocks.order({ :created_at => :desc })


    
    matching_friends = @current_user.received_follow_requests.where({ :status => true})

    @list_of_friends_received = matching_friends.order({ :created_at => :desc })
    @list_of_friends_sent = @current_user.sent_follow_requests.where({ :status => true})

    #@list_of_matching_study_blocks 
    #Have a list of all my friends 
    #for each friends, search their study blocks and return the ones that have a matching time to me 
    @list_of_friends_received.each do |a_friend|

      friend_user = User.where({:id => a_friend.sender_id}).first
      friend_study_blocks = friend_user.study_blocks
      @matching_study_blocks_received = []

      friend_study_blocks.each do |a_study_block|

        start_time = a_study_block.start_time
        end_time = a_study_block.end_time
        dow = a_study_block.day_of_week

          @list_of_study_blocks.each do |my_study_block|

            #if times are the same
            if(start_time == my_study_block.start_time) and (end_time == my_study_block.end_time) and (dow == my_study_block.day_of_week)
              @matching_study_blocks_received.push(a_study_block)
            end 
            #if my friend has a block contained in my block             
            if(start_time > my_study_block.start_time) and (end_time < my_study_block.end_time)
              @matching_study_blocks_received.push(a_study_block)
            end 
            #if my block is contained in a friend block 
            if(start_time < my_study_block.start_time) and (end_time > my_study_block.end_time)
              @matching_study_blocks_received.push(a_study_block)
            end 
            #my block starts outside of a friend block, but ends inside his
            #if (start_time > my_study_block.start_time) and (end_time > my_study_block.end_time)
            #  @matching_study_blocks_received.push(a_study_block)
            #end 
          end 
      end 
    end 

    @list_of_friends_sent.each do |a_friend|

      friend_user = User.where({:id => a_friend.sender_id}).first
      friend_study_blocks = friend_user.study_blocks
      @matching_study_blocks_sent = []

      friend_study_blocks.each do |a_study_block|

        start_time = a_study_block.start_time
        end_time = a_study_block.end_time
        dow = a_study_block.day_of_week

          @list_of_study_blocks.each do |my_study_block|
            #if times match
            if(start_time == my_study_block.start_time) and (end_time == my_study_block.end_time) and (dow == my_study_block.day_of_week)
              @matching_study_blocks_sent.push(a_study_block)
            end 
            #if my block is contained in my friends block
            if(start_time < my_study_block.start_time) and (end_time > my_study_block.end_time)
              @matching_study_blocks_sent.push(a_study_block)
            end 
            #if my friend has a block contained in my block             
            if(start_time > my_study_block.start_time) and (end_time < my_study_block.end_time)
              @matching_study_blocks_received.push(a_study_block)
            end 
            
          end 
      end 
    end 

    render({ :template => "study_blocks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_study_blocks = StudyBlock.where({ :id => the_id })

    @the_study_block = matching_study_blocks.at(0)

    render({ :template => "study_blocks/show.html.erb" })
  end

  def create
    the_study_block = StudyBlock.new
    the_study_block.start_time = params.fetch("query_start_time")
    the_study_block.end_time = params.fetch("query_end_time")
    the_study_block.day_of_week = params.fetch("query_day_of_week")
    the_study_block.user_id = @current_user.id
    the_study_block.effort = params.fetch("query_effort")
    the_study_block.description = params.fetch("query_description")

    if (the_study_block.end_time < the_study_block.start_time)
      redirect_to("/study_blocks", { :notice => "Study block failed to create successfully." })
    elsif the_study_block.valid?
      the_study_block.save
      redirect_to("/study_blocks", { :notice => "Study block created successfully." })
    else
      redirect_to("/study_blocks", { :notice => "Study block failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_study_block = StudyBlock.where({ :id => the_id }).at(0)

    the_study_block.start_time = params.fetch("query_start_time")
    the_study_block.end_time = params.fetch("query_end_time")
    the_study_block.day_of_week = params.fetch("query_day_of_week")
    the_study_block.user_id = params.fetch("query_user_id")
    the_study_block.effort = params.fetch("query_effort")

    if the_study_block.valid?
      the_study_block.save
      redirect_to("/study_blocks/#{the_study_block.id}", { :notice => "Study block updated successfully."} )
    else
      redirect_to("/study_blocks/#{the_study_block.id}", { :alert => "Study block failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_study_block = StudyBlock.where({ :id => the_id }).at(0)

    the_study_block.destroy

    redirect_to("/study_blocks", { :notice => "Study block deleted successfully."} )
  end
end
