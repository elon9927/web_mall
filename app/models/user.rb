class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  # validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: "邮箱格式不合法" }, if: proc { |user| !user.email.blank? }

  CELLPHONE_REG = /\A(\+86|86)?((1[3-8][0-9])+\d{8})\z/
  EMAIL_REG = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  # validates_presence_of :email, message: "邮箱不能为空"
  # validates_format_of :email, message: "邮箱格式不合法",
    # with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
    # if: proc { |user| !user.email.blank? }
  # validates :email, uniqueness: {message: "邮箱已被注册"}

  validates_presence_of :password, message: "密码不能为空",
    if: :need_validate_password
  validates_presence_of :password_confirmation, message: "密码确认不能为空",
    if: :need_validate_password
  validates_confirmation_of :password, message: "两次密码输入不一致",
    if: :need_validate_password
  validates_length_of :password, message: "密码最短为6位", minimum: 6,
    if: :need_validate_password

  validate :validate_email_or_cellphone, on: :create

  has_many :addresses, -> { where(address_type: Address::AddressType::User).order("id desc") }
  belongs_to :default_address, class_name: :Address, optional: true

  has_many :orders
  has_many :payments

  def username
    self.email.blank? ? self.cellphone : self.email.split('@').first
  end

  # TODO
  # 需要添加邮箱和手机号不能重复的校验
  def validate_email_or_cellphone
    if [self.email, self.cellphone].all? { |attr| attr.nil? }
      self.errors.add :base, "邮箱和手机号其中之一不能为空"
      return false
    else
      if self.cellphone.nil?
        if self.email.blank?
          self.errors.add :email, "邮箱不能为空"
          return false
        else
          unless self.email =~ EMAIL_REG
            self.errors.add :email, "邮箱格式不正确"
            return false
          end
        end
      else
        unless self.cellphone =~ CELLPHONE_REG
          self.errors.add :cellphone, "手机号格式不正确"
          return false
        end

        unless $redis.get("#{self.cellphone}_token_key")
          self.errors.add :cellphone, "手机验证码不正确或者已过期"
          return false
        end
      end
    end

    return true
  end

  private
  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
