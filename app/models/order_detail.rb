class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true,
    numericality: {greater_than_or_equal_to: Settings.validation.quantity}
  validates :product_price, presence: true, numericality: true
end
