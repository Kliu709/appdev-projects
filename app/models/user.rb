# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates(:username, { :presence => true })
  validates(:username, { :uniqueness => { :case_sensitive => true } })
  has_secure_password
  has_many(:study_blocks, { :class_name => "StudyBlock", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:sent_follow_requests, { :class_name => "Follower", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:received_follow_requests, { :class_name => "Follower", :foreign_key => "recipient_id", :dependent => :destroy })
end
