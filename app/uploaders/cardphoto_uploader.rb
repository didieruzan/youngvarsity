# encoding: utf-8

class CardphotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  def store_dir
      "users/card_#{mounted_as}/#{model.user_id}"
  end

  process :convert => 'jpg'

  version :large do
    process :crop
    process :from_orientation => [[1039, 697], [697, 1039], [1039, 1039]] # landscape, portrait, square dimensions
  end

  version :ori_medium do
    process :from_orientation => [[325, 218], [218, 325], [325, 325]] # landscape, portrait, square dimensions
  end

  version :medium, :from_version => :large do
    process :from_orientation => [[325, 218], [218, 325], [325, 325]] # landscape, portrait, square dimensions
  end

  version :thumb, :from_version => :large do
    process :from_orientation => [[100, 100], [100, 100], [100, 100]] # landscape, portrait, square dimensions
  end


  def crop
    if model.crop_x.present?
      # resize_to_limit(325, 325)

      manipulate! do |img|
        # calculate relative coordonates
        full_width = img[:width]
        full_height = img[:height]

        rel_x = model.crop_x.to_f / model.crop_iw.to_f
        rel_y = model.crop_y.to_f / model.crop_ih.to_f
        rel_w = model.crop_w.to_f / model.crop_iw.to_f
        rel_h = model.crop_h.to_f / model.crop_ih.to_f

        x = full_width * rel_x
        y = full_height * rel_y
        w = full_width * rel_w
        h = full_height * rel_h

        img.crop("#{w}x#{h}+#{x}+#{y}")
        img

      end
    end
  end


  def filename
     "#{secure_token}.jpg" if original_filename.present?
  end

  def default_url
    "/assets/missing_img.jpg"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end



  def from_orientation(landscape, portrait, square)
      manipulate! do |img|
        if img[:width] > img[:height] # Landscape
          model.orientation = "LANDSCAPE"
          width, height = landscape
        elsif img[:width] < img[:height] # portrait
          model.orientation = "PORTRAIT"
          width, height = portrait
        else # Portrait
          model.orientation = "SQUARE"
          width, height = square
        end
        img.resize "#{width}x#{height}>"
        img
      end
  end



protected

  def secure_token
    var = :"@secure_token_#{mounted_as}"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def landscape? img
    @is_landscape ||= begin
      puts img
      pic = Magick::Image.read(img.path).first
      pic.columns >= pic.rows
    end
  end

  def portrait? img
    return ! landscape?(img)
  end

end
