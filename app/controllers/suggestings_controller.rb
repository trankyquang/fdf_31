  class SuggestingsController < ApplicationController
  before_action :load_suggesting, only: [:destroy, :edit, :update]
  before_action :logged_in_user

  def new
    @suggesting = current_user.suggestings.new
  end

  def create
    @suggesting = current_user.suggestings.new suggesting_params
    if @suggesting.save
      flash[:success] = t "suggesting.suggest_successful"
      redirect_to user_path id: current_user.id, tab: :suggesting_tab
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @suggesting.update_attributes suggesting_params
      flash[:success] = t "suggesting.success_edited"
      redirect_to user_path id: current_user.id, tab: :suggesting_tab
    else
      flash[:danger] = t "suggesting.error_edited"
      redirect_to :back
    end
  end

  def destroy
    if @suggesting.destroy
      flash.now[:success] = t "suggesting.success_deleted"
    else
      flash[:danger] = t "suggesting.error_deleted"
      redirect_to :back
    end
  end

  private

  def load_suggesting
    @suggesting = current_user.suggestings.find_by id: params[:id]
    unless @suggesting
      flash[:danger] = t "suggesting.product_not_found"
      redirect_to :back
    end
  end

  def suggesting_params
    params.require(:suggesting).permit :product_name, :product_description,
      :product_price, :product_image
  end
end
