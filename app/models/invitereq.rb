# == Schema Information
#
# Table name: invitereqs
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invitereq < ActiveRecord::Base
  attr_accessible :email, :name
end
