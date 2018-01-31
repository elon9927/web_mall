class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :address_id, presence: true
  validates :order_no, uniqueness: true

  belongs_to :user
  belongs_to :address
  belongs_to :payment, optional: true

  has_many :line_items, dependent: :destroy

  before_create :gen_order_no

  module OrderStatus
    Initial = 'initial'
    Paid = 'paid'
  end

  def is_paid?
    self.status == OrderStatus::Paid
  end

  def self.create_order_from_carts! user, address, *carts
    carts.flatten!
    address_attrs = address.attributes.except!("id", "created_at", "updated_at")
    order = nil
    transaction do
      order_address = user.addresses.create!(address_attrs.merge("address_type" => Address::AddressType::Order))
      order = user.orders.create!(address: order_address)
      carts.each do |cart|
        order.line_items.create!(
          product: cart.product,
          product_amount: cart.amount,
          total_money: cart.product.price * cart.amount,
          )
      end
      carts.map(&:destroy!)
    end
    order
  end


  private

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
