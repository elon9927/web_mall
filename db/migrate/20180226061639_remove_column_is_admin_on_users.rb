class RemoveColumnIsAdminOnUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_admin
    add_column :users, :role, :integer, default: 0, index: true
  end
end
