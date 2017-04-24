class Suggesting < ApplicationRecord
  belongs_to :user

  mount_uploader :product_image, ProductUploader

  validates :product_name,
    presence: true, length: {maximum: Settings.validation.name}
  validates :product_price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :product_description, presence: true,
    length: {maximum: Settings.validation.content}
  validates :product_image, presence: true
end
