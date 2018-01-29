class RemoveColumnTotalPriceOnOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :total_price
  end
end
