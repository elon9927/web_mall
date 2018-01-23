class Product < ApplicationRecord

  validates :category_id, presence: { message: "分类不能为空" }
  validates :title, presence: { message: "名称不能为空" }
  validates :status, inclusion: { in: %w(on off), message: "商品状态必须为on | off" }
  validates :amount, numericality: { only_integer: true, message: "库存必须为整数" },
    unless: proc { |product| product.amount.blank? }
  validates :amount, presence: { message: "库存不能为空" }
  validates :msrp, presence: { message: "MSRP不能为空" }
  validates :msrp, numericality: { message: "MSRP必须为数字" },
    unless: proc { |product| product.msrp.blank? }
  validates :price, presence: { message: "价格不能为空" }
  validates :price, numericality: { message: "价格必须为数字" },
    unless: proc { |product| product.price.blank? }
  validates :description, presence: { message: "描述信息不能为空" }

  belongs_to :category

  before_create :generate_uuid
  has_many :images, -> { order(weight: 'desc') }, dependent: :destroy
  has_one :main_picture, -> { order(weight: 'desc') },
    class_name: :Image

  scope :onshelf, -> { where(status: Status::On) }

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc{ |attrs| attrs.all? {|k, v| v.blank? }}

  module Status
    On = 'on'
    Off = 'off'
  end


  private
  def generate_uuid
    self.uuid = RandomCode.generate_product_uuid
  end
end
