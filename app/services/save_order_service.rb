class SaveOrderService
  attr_accessor :order, :current_cart, :current_user

  def initialize order, current_cart, current_user
    @order = order
    @current_cart = current_cart
    @current_user = current_user
  end

  def save_order?
    @order.order_status_id = Settings.order.status_pending
    ActiveRecord::Base.transaction do
      @order.save!
      add_order_item
      destroy_cart
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def destroy_cart
    @current_cart.destroy
  end

  def add_order_item
    @current_cart.products.each do |product|
      order_detail = @order.order_details.build product_id: product.id,
        quantity: (@current_cart.quantity product),
        product_price: product.product_price
      order_detail.save!
    end
  end
end
