# == Schema Information
#
# Table name: prodimages
#
#  id         :integer          not null, primary key
#  product_id :integer
#  image_uid  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prod_image :string(255)
#

class Prodimage < ActiveRecord::Base
  attr_accessible :image

  belongs_to :product

  validates :product_id, :presence => true
  validates :image, :presence => true


  image_accessor :image do
    storage_path{|a| "products/#{self.product_id}/#{rand(100)}-#{a.name}" }
  end

  def large
    begin
      if image.width
        image.process(:thumb, '400x').url if !image.nil?
      else
        "/assets/missing_img.jpg"
      end
    rescue
      "/assets/missing_img.jpg"
    end
  end

  def medium
    begin
      if image.width
        image.process(:thumb, '227x').url if !image.nil?
      else
        "/assets/missing_img.jpg"
      end
    rescue
      "/assets/missing_img.jpg"
    end
  end

  def thumb
    begin
      if image.width
        image.process(:thumb, '125x').url if !image.nil?
      else
        "/assets/missing_img.jpg"
      end
    rescue
      "/assets/missing_img.jpg"
    end
  end

  def tiny
    begin
      if image.width
        image.process(:thumb, '75x').url if !image.nil?
      else
        "/assets/missing_img.jpg"
      end
    rescue
      "/assets/missing_img.jpg"
    end
  end

end
