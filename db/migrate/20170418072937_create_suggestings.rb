class CreateSuggestings < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestings do |t|
      t.references :user, foreign_key: true
      t.string :product_name
      t.string :product_image
      t.integer :product_price
      t.text :product_description
      t.boolean :suggesting_status

      t.timestamps
    end
  end
end
