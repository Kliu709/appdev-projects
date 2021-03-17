# == Schema Information
#
# Table name: study_blocks
#
#  id          :integer          not null, primary key
#  day_of_week :string
#  description :string
#  effort      :string
#  end_time    :time
#  medium      :string
#  start_time  :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class StudyBlock < ApplicationRecord
  validates(:start_time, { :presence => true })
  validates(:end_time, { :presence => true })
  validates(:day_of_week, { :presence => true })
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })

  def st_in_words 
    self.start_time.strftime("%I:%M %p")
  end 
  def et_in_words 
    self.end_time.strftime("%I:%M %p")
  end 
end
