class ProductUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
     storage :fog
  else
     storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url
    "/assets/" + [version_name, "default_product_image.png"].compact.join("_")
  end
end
