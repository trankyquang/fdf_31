class Order < ApplicationRecord
  belongs_to :user

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  accepts_nested_attributes_for :order_details

  validates :order_receiving_address, presence: true,
    length: {maximum: Settings.validation.address}
end
