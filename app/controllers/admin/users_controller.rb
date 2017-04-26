class Admin::UsersController < ApplicationController
  before_action :verify_admin
  before_action :load_user, only: :destroy

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.delete_success"
    else
      flash[:danger] = t "user.delete_failed"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "error.user_not_found"
      redirect_to admin_users_path
    end
  end
end
