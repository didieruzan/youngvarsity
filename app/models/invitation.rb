# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  is_active  :boolean          default(TRUE)
#  date_used  :integer
#  sender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipient  :string(255)
#  comments   :string(255)
#

class Invitation < ActiveRecord::Base

  attr_accessible :date_used, :token, :sender, :recipient, :comments, :is_active

  before_create :generate_token



  private

  def generate_token
  	self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end


end
