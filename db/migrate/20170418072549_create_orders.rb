class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :order_status
      t.integer :order_cash
      t.string :order_receiving_address

      t.timestamps
    end
  end
end
