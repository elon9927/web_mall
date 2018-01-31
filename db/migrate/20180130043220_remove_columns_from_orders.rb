class RemoveColumnsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_columns(:orders, :product_id, :product_amount, :total_money)
  end
end
