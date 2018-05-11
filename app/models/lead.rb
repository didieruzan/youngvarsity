# == Schema Information
#
# Table name: leads
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lead < ActiveRecord::Base
  attr_accessible :url
end
