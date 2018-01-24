class Cart < ApplicationRecord

  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product

  scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

  def self.create_or_update! options = {}
    conditions = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }

    cart = Cart.find_by(conditions)
    if cart
      cart.update_attributes!(options.merge(amount: cart.amount + options[:amount]))
    else
      cart = create!(options)
    end
    cart
  end
end
