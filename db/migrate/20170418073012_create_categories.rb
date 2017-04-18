class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :category_description
      t.integer :parent_category

      t.timestamps
    end
  end
end
