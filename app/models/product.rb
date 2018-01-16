class Product < ApplicationRecord
  belongs_to :category

  before_create :generate_uuid


  private
  def generate_uuid
    self.uuid = RandomCode.generate_product_uuid
  end
end
