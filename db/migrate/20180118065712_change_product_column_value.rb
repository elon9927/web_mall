class ChangeProductColumnValue < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:products, :status, 'off')
    change_column_default(:products, :amount, 0)
    change_column(:products, :msrp, :decimal, precision: 10, scale: 2)
    change_column(:products, :price, :decimal, precision: 10, scale: 2)
  end
end
