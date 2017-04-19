class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :address
      t.boolean :gender
      t.string :phone
      t.boolean :is_admin
      t.string :avatar

      t.timestamps
    end
    add_index :users, [:user_name, :email], unique: true
  end
end
