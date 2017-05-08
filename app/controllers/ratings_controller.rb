class RatingsController < ApplicationController

  def create
    @product = Product.find(rating_params[:product_id].to_i)
    @rating = Rating.new rating_params
    if @rating.save
      @product.update_attributes product_rating_point:
        cal_product_rating_point(@product)
      @product.update_attributes product_rating_times:
        cal_product_rating_times(@product)
      flash[:success] = t "rating.success"
    else
      flash[:danger] = t "rating.failure"
    end
    redirect_to @product
  end

  private
  def rating_params
    params.require(:rating).permit :user_id, :product_id, :rating_point
  end

  def cal_product_rating_times product
    if product.product_rating_times.nil?
      product.product_rating_times = 0
    else
      product.product_rating_times + 1
    end
  end

  def cal_product_rating_point product
    if product.product_rating_point.nil?
      product.product_rating_point = 0
    end
    if product.product_rating_times.nil?
      product.product_rating_times = 0
    end
    (product.product_rating_point * product.product_rating_times +
      + rating_params[:rating_point].to_i)/(product.product_rating_times + 1)
  end
end
