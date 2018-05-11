# == Schema Information
#
# Table name: photos
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  photo_image_uid :string(255)
#  guid            :string(255)
#  photo_img       :string(255)
#  description     :string(255)
#

class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many   :comments

  validates :user_id, :presence => true
  validates :photo_img, :presence => true
  # validates :photo_image, :presence => true

  attr_accessible :photo_img, :description#, :photo_image

  # image_accessor :photo_image do
  #   storage_path{|a| "photos/#{self.user_id}/#{rand(100)}-#{a.name}" }
  # end

  default_scope :order => "photos.created_at DESC"

  mount_uploader :photo_img, PhotoUploader

  before_save :set_guid

  # Virtual Attributes
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :crop_iw, :crop_ih


  def crop_photo
    if self.crop_x.present?
      photo_img.cache_stored_file!
      photo_img.retrieve_from_cache!(photo_img.cache_name)
      photo_img.recreate_versions!
    end
  end

  def medium

  	# self.photo_image.url
   #  image = self.photo_image
  	# image.process(:thumb, '227x').url if !image.nil?
    self.photo_img_url(:medium)
  end

  def large

    # self.photo_image.url
    image = self.photo_image
    image.process(:thumb, '640x').url if !image.nil?
  end

  def large1024
    self.photo_img_url(:full1024)
  end

  def full800
    self.photo_img_url(:full800)
  end

  def description
    @description ||= self[:description].capitalize if !self[:description].blank?
  end

   private

    def set_guid
      if self.guid.nil?
        # we have a create (to whom ever is reading this, I am sure I could use something like before_create instead, but I prefer this more controlled method)
          self.guid = Digest::MD5.hexdigest("#{id}--#{Time.now.to_i}#{rand(9999)}")
      end
    end


end
