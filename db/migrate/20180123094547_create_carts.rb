class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :user_uuid
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
    add_index :carts, [:user_id]
    add_index :carts, [:user_uuid]
  end
end
