class User < ApplicationRecord
  authenticates_with_sorcery!

  # attr_accessor :password, :password_confirmation

  validates :email, presence: {message: "邮箱不能为空"}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: "邮箱格式不合法" }, if: proc { |user| !user.email.blank? }

  #with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
  validates :email, uniqueness: true
  validates :password, presence: { message: "密码不能为空"}, if: :need_validate_password

  validates :password_confirmation, presence: { message: "确认密码不能为空"}, if: :need_validate_password
  validates :password, confirmation: { message: "两次密码输入不一致"}, if: :need_validate_password
  validates :password, length: { maximum: 6, message: "密码最短为6位" }, if: :need_validate_password


  private
  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
