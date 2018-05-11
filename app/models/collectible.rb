# == Schema Information
#
# Table name: collectibles
#
#  id               :integer          not null, primary key
#  srcphoto         :string(255)
#  user_id          :integer
#  field_pos        :string(255)
#  team_name        :string(255)
#  jersey_num       :integer
#  photo_front      :string(255)
#  photo_back       :string(255)
#  style            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  orientation      :string(255)
#  latest_stats     :string(255)
#  shipping_address :text
#  phone            :string(255)
#  to_print         :boolean
#

class Collectible < ActiveRecord::Base
  attr_accessible :field_pos, :jersey_num, :photo_back, :photo_front, :srcphoto, :style, :team_name
  attr_accessible :user_id, :latest_stats, :remote_srcphoto_url, :weight, :height_ft, :height_in
  attr_accessible :shipping_address, :phone, :to_print


  validates :jersey_num, :numericality => { :allow_blank => true, :only_integer => true, :less_than_or_equal_to => 999 }

  validates :weight, :numericality => { :allow_blank => true, :only_integer => true }
  validates :height_ft, :numericality => { :allow_blank => true, :only_integer => true }
  validates :height_in, :numericality => { :allow_blank => true, :only_integer => true }



  belongs_to :user, touch: true

  mount_uploader :srcphoto, CardphotoUploader

  #after_update :crop_card_img

  # Virtual Attributes
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :crop_iw, :crop_ih, :weight, :height_ft, :height_in

  def crop_card_img
    if crop_x.present?
      srcphoto.cache_stored_file!
      srcphoto.retrieve_from_cache!(srcphoto.cache_name)
      srcphoto.recreate_versions!
    end
  end



end
