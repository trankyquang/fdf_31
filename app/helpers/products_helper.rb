module ProductsHelper
  def recently_viewed_products
    @recently_viewed_products || RecentlyViewedProduct.new(cookies)
  end

  def group_four_product index, count, product
    if (index/4).to_i == count
      content_tag :div, class: "col-md-3" do
        link_to product_path(product), class: "thumbnail" do
          image_tag product.picture_url, alt: t("product_picture")
        end
      end
    end
  end

  def show_combobox_category_product product_item
    product_item.collection_select :category_id, Category.all_category, :id,
      :category_name
  end

  def render_html_menu
    categories = Category.all
    show_categories categories, nil
  end

  def show_categories categories, parent_category
    result = ""
    categories.each do |category|
      if category[:parent_category] == parent_category
        if categories.where(parent_category: category[:id]).count != 0
          result += "<li><a href='https://food-drink-31.herokuapp.com/products?category="+ category[:id].to_s+"'>" +
            + category[:category_name] + "</a>" + "<ul>" +
            + show_categories(categories, category[:id]) + "</ul>" + "</li>"
        else
          result += "<li><a href='https://food-drink-31.herokuapp.com/products?category="+ category[:id].to_s+"'>" +
          + category[:category_name] + "</a>" + "</li>"
        end
      end
    end
    result
  end
end
