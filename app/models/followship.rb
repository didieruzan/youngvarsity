# == Schema Information
#
# Table name: followships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Followship < ActiveRecord::Base

  belongs_to :follower, :foreign_key => "follower_id", :class_name => "User"
  belongs_to :followed, :foreign_key => "followed_id", :class_name => "User"

  validates :follower_id, :presence => true
  validates :followed_id, :presence => true

  attr_accessible :followed_id
end
