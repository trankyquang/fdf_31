class Admin::OrdersController < ApplicationController
  before_action :verify_admin
  before_action :load_order, only: [:show, :destroy, :update]

  def index
    @orders = Order.paginate page: params[:page],
      per_page: Settings.order.per_page
  end

  def show
  end

  def update
    case params[:order_action]
    when "reject"
      if @order.reject?
        flash[:success] = t "order.flash_reject"
        redirect_to admin_orders_path
      else
        flash[:danger] = t "order.error_when_reject"
        redirect_to admin_order_path
      end
    when "confirm"
      if @order.ship?
        flash[:success] = t "order.flash_confirm"
        redirect_to admin_orders_path
      else
        flash[:danger] = t "order.error_when_confirm"
        redirect_to admin_order_path
      end
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "order.order_not_found"
      redirect_to admin_orders_path
    end
  end
end
