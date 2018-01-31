class LineItem < ApplicationRecord

  validates :product_id, presence: true
  validates :product_amount, presence: true
  validates :total_money, presence: true

  belongs_to :order
  belongs_to :product

end
