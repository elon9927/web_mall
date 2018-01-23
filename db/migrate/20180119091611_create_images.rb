class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :attachment
      t.integer :weight, default: 0
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :images, [:product_id, :weight]
  end
end
