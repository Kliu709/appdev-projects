class StudyBlocksController < ApplicationController
  def index
    my_study_blocks = @current_user.study_blocks

    @list_of_study_blocks = my_study_blocks.order({ :created_at => :desc })
    @sunday_blocks = my_study_blocks.where({:day_of_week => "Sunday"}).order({:start_time => :asc})
    @monday_blocks = my_study_blocks.where({:day_of_week => "Monday"}).order({:start_time => :asc})
    @tuesday_blocks = my_study_blocks.where({:day_of_week => "Tuesday"}).order({:start_time => :asc})
    @wednesday_blocks = my_study_blocks.where({:day_of_week => "Wednesday"}).order({:start_time => :asc})
    @thursday_blocks = my_study_blocks.where({:day_of_week => "Thursday"}).order({:start_time => :asc})
    @friday_blocks = my_study_blocks.where({:day_of_week => "Friday"}).order({:start_time => :asc})
    @saturday_blocks = my_study_blocks.where({:day_of_week => "Saturday"}).order({:start_time => :asc})

    
    matching_friends = @current_user.received_follow_requests.where({ :status => true}).or(@current_user.sent_follow_requests.where({ :status => true}))

    @list_of_friends = matching_friends.order({ :created_at => :desc })
    @matching_study_blocks = []
    @list_of_friends.each do |a_friend|
    #a_friend = @list_of_friends.first
      if @current_user.id == a_friend.recipient_id 
        @friend_user = User.where({:id => a_friend.sender_id}).first
      else 
        @friend_user = User.where({:id => a_friend.recipient_id}).first 
      end 
      friend_study_blocks = @friend_user.study_blocks
      

      friend_study_blocks.each do |a_study_block|

        start_time = a_study_block.start_time
        end_time = a_study_block.end_time
        dow = a_study_block.day_of_week
        @matching = ""

          @list_of_study_blocks.each do |my_study_block|
              #if times are the same
              if(my_study_block.day_of_week == dow)
                if(start_time == my_study_block.start_time) and (end_time == my_study_block.end_time) and (dow == my_study_block.day_of_week)
                  @matching_study_blocks.push(a_study_block)
                #if my block is in a friends block       
                elsif (start_time..end_time).include?(my_study_block.start_time) and (start_time..end_time).include?(my_study_block.end_time)
                  @matching_study_blocks.push(a_study_block)
                #if my friends block is in my block
                elsif (my_study_block.start_time..my_study_block.end_time).include?(start_time) and (my_study_block.start_time..my_study_block.end_time).include?(end_time)
                  @matching_study_blocks.push(a_study_block)
                #if my block starts in my friends block, but ends after it
                elsif (start_time..end_time).include?(my_study_block.start_time) and ((my_study_block.start_time - end_time) < 1800)
                  @matching_study_blocks.push(a_study_block)
                #if my block ends in my friends block, but starts before it
                elsif (start_time..end_time).include?(my_study_block.end_time) and ((my_study_block.end_time - start_time) > 1800)
                  @matching_study_blocks.push(a_study_block)
                else 
                  next 
                end
              end 
          end 
      end 
    end 

    #@matching_sunday_blocks = @matching_study_blocks.where({:day_of_week => "Sunday"}).order({:start_time => :asc})
    #@matching_monday_blocks = @matching_study_blocks.where({:day_of_week => "Monday"}).order({:start_time => :asc})
    #@matching_tuesday_blocks = @matching_study_blocks.where({:day_of_week => "Tuesday"}).order({:start_time => :asc})
    #@matching_wednesday_blocks = @matching_study_blocks.where({:day_of_week => "Wednesday"}).order({:start_time => :asc})
    #@matching_thursday_blocks = @matching_study_blocks.where({:day_of_week => "Thursday"}).order({:start_time => :asc})
    #@matching_friday_blocks = @matching_study_blocks.where({:day_of_week => "Friday"}).order({:start_time => :asc})
    #@matching_saturday_blocks = @matching_study_blocks.where({:day_of_week => "Saturday"}).order({:start_time => :asc})
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
    the_study_block.medium= params.fetch("query_medium")

    if (the_study_block.end_time < the_study_block.start_time)
      redirect_to("/study_blocks", { :alert => "End time cannot be earlier than start time." })
    elsif the_study_block.valid?
      the_study_block.save
      redirect_to("/study_blocks", { :notice => "Study block created successfully." })
    else
      redirect_to("/study_blocks", { :alert => "Study block failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_study_block = StudyBlock.where({ :id => the_id }).at(0)

    the_study_block.start_time = params.fetch("query_start_time")
    the_study_block.end_time = params.fetch("query_end_time")
    the_study_block.day_of_week = params.fetch("query_day_of_week")
    the_study_block.user_id = @current_user.id
    the_study_block.effort = params.fetch("query_effort")
    the_study_block.description = params.fetch("query_description")
    the_study_block.medium= params.fetch("query_medium")

    if the_study_block.valid?
      the_study_block.save
      redirect_to("/study_blocks", { :notice => "Study block updated successfully."} )
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
