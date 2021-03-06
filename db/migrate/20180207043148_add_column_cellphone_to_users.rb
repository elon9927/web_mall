class AddColumnCellphoneToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cellphone, :string

    remove_index :users, [:email]
    add_index :users, [:email]
    add_index :users, [:cellphone]

    change_column :users, :email, :string, null: true
  end
end
