# == Schema Information
#
# Table name: followers
#
#  id           :integer          not null, primary key
#  status       :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class Follower < ApplicationRecord
  belongs_to(:sender, { :required => false, :class_name => "User", :foreign_key => "sender_id" })
  belongs_to(:recipient, { :required => false, :class_name => "User", :foreign_key => "recipient_id" })
  validates(:sender_id, { :presence => true })
  validates(:recipient_id, { :presence => true })
  validates(:recipient_id, { :uniqueness => { :scope => ["sender_id"], :message => "already requested" } })

  
end
