class PhotoUploader < CarrierWave::Uploader::Base


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
    "users/photos/#{model.user_id}/#{model.guid}"
  end

  version :full1024 do
    process :crop
    process :resize_to_fit => [1024,10000]
  end

  version :full800, :from_version => :full1024 do
    process :resize_to_fit => [800,10000]
  end

  version :large, :from_version => :full800 do
    process :resize_to_fit => [640,10000]
  end

  version :medium, :from_version => :large do
    process :resize_to_fit => [227,10000]
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



  # def filename
  #    "#{secure_token}.#{file.extension}" if original_filename.present?
  # end

  def default_url
    "/assets/missing_img.jpg"
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
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

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
