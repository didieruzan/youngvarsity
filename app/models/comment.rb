# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post       :text
#  user_id    :integer
#  photo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guid       :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  attr_accessible :post, :photo_id


  before_save :set_guid


  private
  
    def set_guid
      if self.guid.nil?
        self.guid = Digest::MD5.hexdigest("#{id}--#{Time.now.to_i}#{rand(9999)}")
      end
    end


end
