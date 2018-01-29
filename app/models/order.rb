class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :product_amount, presence: true
  validates :total_money, presence: true
  validates :order_no, uniqueness: true

  belongs_to :user
  belongs_to :product
  belongs_to :address

  before_create :gen_order_no

  def self.create_order_from_carts! user, address, *carts
    carts.flatten!
    address_attrs = address.attributes.except!("id", "created_at", "updated_at")

    transaction do
      order_address = user.addresses.create!(address_attrs.merge("address_type" => Address::AddressType::Order))
      carts.each do |cart|
        user.orders.create!(
          address: order_address,
          product: cart.product,
          product_amount: cart.amount,
          total_money: cart.product.price * cart.amount,
          )
      end
      carts.map(&:destroy!)
    end
  end


  private

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
