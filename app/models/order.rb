class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  accepts_nested_attributes_for :order_details

  validates :order_receiving_address, presence: true,
    length: {maximum: Settings.validation.address}

  scope :by_status_id, ->status_id do
    where order_status_id: status_id if status_id.present?
  end

  def order_details_count
    order_details.size
  end

  def total_summary
    order_details.to_a.reduce(0) {|sum, item| sum + item.product_price*item.quantity}
  end

  def reject?
    ActiveRecord::Base.transaction do
      order_details.each do |order_detail|
        product = order_detail.product
        product.update_attributes! product_quantity: product.product_quantity + order_detail.quantity
        destroy!
      end
    true
    end
  rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordNotDestroyed
    false
  end

  def ship?
    update_attributes order_status_id: Settings.order.status_confirm,
      order_cash: total_summary
  end
end
