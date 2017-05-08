class UserUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.validation.picture_size,
    Settings.validation.picture_size]
  # if Rails.env.production?
  #    storage :fog
  # else
  #    storage :file
  # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url
    "/assets/" + [version_name, "default_avatar.png"].compact.join("_")
  end
end
