class OrderStatus < ApplicationRecord
  has_many :orders

  validates :name, presence: true, length: {maximum: Settings.category.max_name}
  validates :description, presence: true,
    length: {maximum: Settings.category.max_description}
end
