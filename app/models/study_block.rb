# == Schema Information
#
# Table name: study_blocks
#
#  id          :integer          not null, primary key
#  day_of_week :string
#  effort      :string
#  end_time    :time
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

end
