desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  require 'faker'
  User.destroy_all
  Follower.destroy_all
  StudyBlock.destroy_all

  3.times do 
    user = User.new
    user.username = Faker::Name.first_name 
    user.email = Faker::Internet.email 
    user.password = "password"
    user.save 
  end 
  user = User.new
  user.username = "alice"
  user.email = "alice@example.com"
  user.password = "password"
  user.save 
  p "Added #{User.count} Users"


  days = {0 => "Sunday",
    1 => "Monday", 
    2 => "Tuesday",
    3 => "Wednesday",
    4 => "Thursday",
    5 => "Friday",
    6 => "Saturday"}
  start_time = Time.now 
  end_time = Time.now + 30*60 #30 minutes later 
  dow = days[end_time.wday]
  effort = [0, 1, 2, 3]

  
  study_block = StudyBlock.new
  study_block.start_time = start_time
  study_block.end_time = end_time
  study_block.day_of_week = dow
  study_block.user_id = User.all.sample.id
  study_block.effort = effort.sample
  study_block.save
  p "Added #{StudyBlock.count}  Study_block"

  
end
