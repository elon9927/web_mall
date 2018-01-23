class RemoveColumnImageOnProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column(:products, :image)
  end
end
