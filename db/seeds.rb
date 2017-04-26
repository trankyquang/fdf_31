User.create!(user_name: "admin", email: "admin@framgia.com",
password: "th0ngmjnh", password_confirmation: "th0ngmjnh", is_admin: true)

100.times do |i|
  User.create!(user_name:"user_#{i}", email: Faker::Internet.email,
  password: "123456", password_confirmation: "123456", is_admin: false)
end

10.times do |i|
  Category.create!(category_name:"Category_#{i}",
    category_description:"category_description_#{i}")
end

100.times do |i|
  Product.create!(product_name:"Product#{i}",
    product_description:"Product_description_#{i}", category_id: i%11,
    product_price: i*5000, product_quantity: 10)
end
