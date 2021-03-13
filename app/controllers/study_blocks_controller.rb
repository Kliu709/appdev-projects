class StudyBlocksController < ApplicationController
  def index
    matching_study_blocks = @current_user.study_blocks

    @list_of_study_blocks = matching_study_blocks.order({ :created_at => :desc })

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
    the_study_block.user_id = params.fetch("query_user_id")
    the_study_block.effort = params.fetch("query_effort")

    if the_study_block.valid?
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
