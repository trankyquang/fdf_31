class UsersController < ApplicationController
  before_action :find_user, except: [:new, :create, :index]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "signup.success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "edit.changed"
      redirect_to @user
    else
      flash[:danger] =  t "edit.fails"
      render :edit
    end
  end

  def show
    @recently_viewed_products = recently_viewed_products.reverse
      .paginate page: params[:page], per_page: Settings.recently_viewed.per_page
    @orders = current_user.orders.paginate page: params[:page],
      per_page: Settings.recently_viewed.per_page
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      render :error
    end
  end

  def user_params
    params.require(:user).permit :user_name, :email, :password,
    :password_confirmation, :avatar
  end
end
