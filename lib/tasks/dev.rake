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


  days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  now_time = Time.now
  times = []
  i = 1 
  while i < 8 do 
    times.push(now_time + 600 * i)
    i = i + 1 
  end 

  effort = [0, 1, 2, 3]
  descriptions = ["FINALS WEEK GG", "Studying math!", "come hang out with :)", "I have a pset due at midnight don't talk but sit with me"]
  7.times do 
    study_block = StudyBlock.new
    study_block.start_time = times.sample
    study_block.end_time = times.sample
    study_block.day_of_week = days.sample
    study_block.user_id = User.all.sample.id
    study_block.effort = effort.sample
    study_block.description = descriptions.sample
    study_block.save
  end 
  p "Added #{StudyBlock.count} Study blocks"

users = User.all
bool = [false, true]
10.times do 
  fr = Follower.new
  fr.status = bool.sample
  fr.sender_id = users.sample.id 
  fr.recipient_id = users.sample.id 
  fr.save
end

p "Added #{Follower.count} FollowRequests"
  
end
