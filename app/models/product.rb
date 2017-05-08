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
  validates :product_quantity, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validates :category_id, presence: true

  scope :by_name, ->name do
    where "product_name LIKE '%#{name}%'" if name.present?
  end

  scope :by_category, ->category do
    where "category_id = '#{category}'" if category.present?
  end

  scope :by_rating, ->rating_point do
    where "product_rating_point >= '#{rating_point}'" if rating_point.present?
  end

  scope :by_min_price, ->min_price do
    where "product_price >= '#{min_price}'" if min_price.present?
  end

  scope :by_max_price, ->max_price do
    where "product_price <= '#{max_price}'" if max_price.present?
  end

  scope :top_new_products, -> {order created_at: :desc}

  def is_out_of_stock? order_quantity
    product_quantity < order_quantity
  end
end
