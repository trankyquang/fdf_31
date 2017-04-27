class Admin::SuggestingsController < ApplicationController
  before_action :verify_admin
  before_action :load_suggesting, only: :destroy

  def index
    @suggestings = Suggesting.paginate page: params[:page],
      per_page: Settings.product.products_per_page
  end

  def destroy
    if @suggesting.destroy
      flash.now[:success] = t "product.delete_success"
    else
      flash.now[:danger] = t "product.delete_failed"
    end
    redirect_to admin_suggestings_path
  end

  private

  def load_suggesting
    @suggesting = Suggesting.find_by id: params[:id]
    unless @suggesting
      flash[:danger] = t "product.product_not_found"
      redirect_to admin_suggestings_path
    end
  end
end
