desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  require 'faker'
  User.destroy_all
  Follower.destroy_all
  StudyBlock.destroy_all
=begin
  3.times do 
    user = User.new
    user.username = Faker::Name.first_name 
    user.email = Faker::Internet.email 
    user.password = "password"
    user.save 
  end 
=end 
  user1 = User.new
  user1.username = "alice"
  user1.email = "alice@example.com"
  user1.password = "password"
  user1.save 

  user2 = User.new
  user2.username = "bob"
  user2.email = "bob@example.com"
  user2.password = "password"
  user2.save 
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
  descriptions = ["FINALS WEEK GG", "Studying math!", "come hang out with me :)", "I have a pset due at midnight don't talk but sit with me"]
  study_block = StudyBlock.new
  study_block.start_time = Time.new(2000, 1, 1, 21)
  study_block.end_time = Time.new(2000, 1, 1, 23)
  study_block.day_of_week = "Saturday"
  study_block.user_id = User.all.first.id
  study_block.effort = effort.sample
  study_block.description = descriptions.sample
  study_block.save

  study_block = StudyBlock.new
  study_block.start_time = Time.new(2000, 1, 1, 21)
  study_block.end_time = Time.new(2000, 1, 1, 23)
  study_block.day_of_week = "Saturday"
  study_block.user_id = User.all.at(1).id
  study_block.effort = effort.sample
  study_block.description = descriptions.sample
  study_block.save

=begin
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
=end 
  p "Added #{StudyBlock.count} Study blocks"


  fr = Follower.new
  fr.status = true
  fr.sender_id = User.all.first.id
  fr.recipient_id = User.all.at(1).id
  fr.save

  fr = Follower.new
  fr.status = true
  fr.sender_id = User.all.at(1).id
  fr.recipient_id = User.all.first.id
  fr.save
=begin
users = User.all
bool = [false, true]
10.times do 
  fr = Follower.new
  fr.status = bool.sample
  fr.sender_id = users.sample.id 
  fr.recipient_id = users.sample.id 
  fr.save
end
=end 
p "Added #{Follower.count} FollowRequests"
  
end
