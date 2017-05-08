class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProductsHelper
  include CartsHelper

  def verify_admin
    unless current_user.is_admin?
      redirect_to root_path
      flash[:danger] = "login_page.Permission"
    end
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login_page.please_login"
      redirect_to login_url
    end
  end

end
