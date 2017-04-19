class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :product_name
      t.text :product_description
      t.integer :product_price
      t.integer :product_quantity
      t.float :product_rating_point
      t.integer :product_rating_times

      t.timestamps
    end
  end
end
