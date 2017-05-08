module CategoriesHelper

  def show_index index
    return index if params[:page].nil?
    (params[:page].to_i - 1) * 10 + index
  end

  def show_combobox_categories category_item
    category_item.collection_select :parent_category, Category.all_category,
      :id, :category_name
  end

  def get_parent_category_name parent_category
    if parent_category.present?
      Category.find_by(id: parent_category).category_name
    else
      "N/A"
    end
  end
end
