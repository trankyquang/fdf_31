class Admin::ProductsController < ApplicationController
  before_action :verify_admin
  before_action :load_product, except: [:new, :create, :index]
  before_action :load_suggesting, only: [:new, :create]

  def index
    @products = Product.top_new_products.paginate page: params[:page],
      per_page: Settings.product.products_per_page
  end

  def new
    @product = Product.new
    if @suggesting.present?
      @product.assign_attributes(
        product_name: @suggesting.product_name,
        product_price: @suggesting.product_price,
        product_description: @suggesting.product_description,
        picture: @suggesting.product_image)
    end
  end

  def create
    @product = Product.new product_params
    if !@product.picture? && @suggesting.present? && @suggesting.product_image?
      @product.assign_attributes(picture: @suggesting.product_image)
    end
    if @product.save
      redirect_to admin_products_path
      @suggesting
        .update_attributes(suggesting_status: true) if @suggesting.present?
    else
      @errors_count = @product.errors.size
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "product.update_success"
    else
      flash[:danger] = t "product.update_failed"
    end
    redirect_to admin_product_path(@product)
  end

  def show
  end

  def destroy
    if @product.destroy
      flash.now[:success] = t "product.delete_success"
    else
      flash.now[:danger] = t "product.delete_failed"
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit :product_name, :product_description,
      :product_price, :product_quantity, :picture, :category_id,
      :product_rating_point, :product_rating_times
  end

  def load_suggesting
    @suggesting = Suggesting.find_by id: params[:suggesting_id]
  end

  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "product.product_not_found"
      redirect_to admin_products_path
    end
  end
end
