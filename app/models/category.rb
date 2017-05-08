class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :category_name, presence: true,
    length: {maximum: Settings.validation.name}
  validates :category_description, presence: true,
    length: {maximum: Settings.validation.content}

  scope :all_category, -> {order(:category_name)}
end
