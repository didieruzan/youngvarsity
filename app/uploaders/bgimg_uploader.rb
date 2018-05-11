# encoding: utf-8

class BgimgUploader < CarrierWave::Uploader::Base

  include CarrierWave::MimeTypes

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  process :set_content_type

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
      "users/#{mounted_as}/#{model.guid}"
  end

  process :convert => 'jpg'

  version :full do
    process :crop
    process :resize_to_fit => [1024, 10000] # 10000 is so that there's no limit
  end

  version :psi_bg_framed, :from_version => :full do
    process :psi_bg_framed
  end

  version :med, :from_version => :full do
    process :resize_to_fit => [380, 10000] # 10000 is so that there's no limit
  end

  version :thumb, :from_version => :med do
        process :resize_to_fit => [122, 10000] # 10000 is so that there's no limit
  end


  def psi_bg_framed

    manipulate! format: "jpg" do |source|
      background_frame_path = Rails.root.join("app/assets/images/imagemagick/collage_hoz_frame.jpg")
      watermark_path = Rails.root.join("app/assets/images/imagemagick/collage_watermark_med.png")

      background_frame = Magick::Image.read(background_frame_path).first
      watermark = Magick::Image.read(watermark_path).first

      source = source.resize_to_fill(455, 308)
      composite = background_frame.composite!(source, 23, 20, Magick::OverCompositeOp)
      composite.composite!(watermark, 0, 0, Magick::OverCompositeOp)

    end
  end


  def crop

    if model.crop_x.present?
      manipulate! do |img|
        full_w = img.columns
        full_h = img.rows

        rel_crop_x = model.crop_x.to_f / model.crop_iw.to_f
        rel_crop_y = model.crop_y.to_f / model.crop_ih.to_f
        rel_crop_w = model.crop_w.to_f / model.crop_iw.to_f
        rel_crop_h = model.crop_h.to_f / model.crop_ih.to_f

        dest_x = full_w * rel_crop_x
        dest_y = full_h * rel_crop_y
        dest_w = full_w * rel_crop_w
        dest_h = full_h * rel_crop_h

        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(dest_x, dest_y, dest_w, dest_h)
      end
    end
  end


  def filename
     "#{secure_token}.jpg" if original_filename.present?
  end

  def default_url
    "/assets/missing_img.jpg"
  end

  protected
  def secure_token
    var = :"@secure_token_#{mounted_as}"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end



  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end


end
