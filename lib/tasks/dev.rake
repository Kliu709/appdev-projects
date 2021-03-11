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
  p "Added #{User.count} Users"
end
