class RecentlyViewedProduct < CookieCollection

  def initialize cookies
    super cookies
    self.ids = ids.last 12
    ids.each {|product_id| push Product.find_by(id: product_id)}
  end

  def push product
    delete product
    while length > 11
      delete_at 0
    end
    super product
  end
end
