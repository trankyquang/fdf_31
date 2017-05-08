class ProductsController < ApplicationController
  before_action :load_product, only: :show
  before_action :load_products, only: :index

  def index
    if !params[:category].nil?
      @products = @products.by_category(params[:category].to_i)
      return
    end
  end

  def show
    recently_viewed_products.push @product
    @rating = Rating.new
  end

  private
  def load_products
    @products = Product.by_name(params[:product_name])
      .by_category(params[:category_id])
      .by_rating(params[:product_rating_point])
      .by_min_price(params[:product_price_from])
      .by_max_price(params[:product_price_to])
      .paginate page: params[:page],
      per_page: Settings.product.products_per_page
    @categories = Category.all || {}

    return if @products
    flash[:danger] = t "product.product_not_found"
    redirect_to root_url
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "product.product_not_found"
    redirect_to root_url
  end
end
