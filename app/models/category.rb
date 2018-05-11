# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id

  has_ancestry

  has_many :categorizations
  has_many :products, :through => :categorizations

end
