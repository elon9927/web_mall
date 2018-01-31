class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :product_amount
      t.decimal :total_money, precision: 10, scale: 2

      t.timestamps
    end

    add_index :line_items, [:order_id]
    add_index :line_items, [:product_id]
  end
end
