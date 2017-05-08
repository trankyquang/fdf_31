class CategoriesController < ApplicationController

  before_action :find_category, except: [:index, :create, :new]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.category.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.create_success"
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t "category.update_success"
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.delete_success"
    else
      flash[:notice] = t "category.delete_failure"
    end
    redirect_to categories_path
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    render :error unless @category.present?
  end

  def category_params
    params.require(:category).permit :category_name, :category_description,
      :parent_category
  end
end
