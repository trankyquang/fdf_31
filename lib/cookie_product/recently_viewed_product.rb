class RecentlyViewedProduct < CookieCollection

  def initialize cookies
    super cookies
    self.ids = ids.last Settings.recently_viewed.cookie_size
    ids.each {|product_id| push Product.find_by(id: product_id)}
  end

  def push product
    delete product
    while length > Settings.recently_viewed.cookie_size - 1
      delete_at 0
    end
    super product
  end
end
