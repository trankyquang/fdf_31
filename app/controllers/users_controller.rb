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

  def show
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
