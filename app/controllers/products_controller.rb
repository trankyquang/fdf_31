class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    @products = Product.top_new_products.paginate page: params[:page],
      per_page: Settings.product.products_per_page
  end

  def show
    recently_viewed_products.push @product
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "product.product_not_found"
    redirect_to root_url
  end
end
