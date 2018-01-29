class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :type
      t.string :contact_name
      t.string :cellphone
      t.string :address
      t.string :zipcode

      t.timestamps
    end
    add_index :addresses, [:user_id, :type]
  end
end
