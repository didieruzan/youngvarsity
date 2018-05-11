# == Schema Information
#
# Table name: wishings
#
#  id         :integer          not null, primary key
#  product_id :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wishing < ActiveRecord::Base
  attr_accessible :position, :product_id, :user_id

  belongs_to :product, :foreign_key => "product_id", :class_name => "Product"
  belongs_to :wisher, :foreign_key => "user_id", :class_name => "User"

end
