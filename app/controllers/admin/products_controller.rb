class Admin::ProductsController < ApplicationController
  before_action :verify_admin
  before_action :load_product, except: [:new, :create, :index]

  def index
    @products = Product.all.paginate page: params[:page],
      per_page: Settings.product.products_per_page
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to admin_products_path
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
      redirect_to admin_products_path
    end
    redirect_to admin_products_path
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
      :product_price, :product_quantity, :picture, :category_id
  end

  def load_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "product.product_not_found"
      redirect_to admin_products_path
    end
  end
end
