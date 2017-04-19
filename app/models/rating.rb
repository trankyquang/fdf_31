class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating_point, presence: true,
  numericality: {greater_than_or_equal_to: Settings.validation.point}
  validates :user_id, presence: true
  validates :product_id, presence: true
end
