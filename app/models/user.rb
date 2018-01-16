class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation
=begin
  validates :email, presence: {message: "邮箱不能为空"}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: "邮箱格式不合法" }, if: proc { |user| !user.email.blank? }

  #with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
  validates :email, uniqueness: true
  validates :password, presence: { message: "密码不能为空"}, if: :need_validate_password

  validates :password_confirmation, presence: { message: "确认密码不能为空"}, if: :need_validate_password
  validates :password, confirmation: { message: "两次密码输入不一致"}, if: :need_validate_password
  validates :password, length: { maximum: 6, message: "密码最短为6位" }, if: :need_validate_password
=end

  validates_presence_of :email, message: "邮箱不能为空"
  validates_format_of :email, message: "邮箱格式不合法",
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
    if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: {message: "邮箱已被注册"}

  validates_presence_of :password, message: "密码不能为空",
    if: :need_validate_password
  validates_presence_of :password_confirmation, message: "密码确认不能为空",
    if: :need_validate_password
  validates_confirmation_of :password, message: "两次密码输入不一致",
    if: :need_validate_password
  validates_length_of :password, message: "密码最短为6位", minimum: 6,
    if: :need_validate_password

  def username
    self.email.split('@').first
  end


  private
  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
