class Product < ApplicationRecord
  belongs_to :category

  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  mount_uploader :picture, ProductUploader

  validates :product_name, presence: true,
    length: {maximum: Settings.validation.name}
  validates :product_description, presence: true,
    length: {maximum: Settings.validation.content}
  validates :product_price, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.price}
  validates :product_quantity, presence: true, numericality: {only_integer: true}
  validates :category_id, presence: true

  scope :by_name, -> name do
    where "name LIKE '%#{name}%'" if name.present?
  end

  scope :top_new_products, -> {order created_at: desc}

end
