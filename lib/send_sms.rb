# encoding: utf-8
require 'net/http'

module SendSms
  class << self

    MESSAGE_SUFFIX = "【XX商城】"

    def to(cellphone)

      # phones = Array(cellphone).join(',')
      res = Net::HTTP.post_form(URI.parse("#{ENV['SMS_URL']}/sendsms.action?cdkey=#{ENV['CDKEY']}&password=#{ENV['PASSWORD']}"), phone: cellphone, message: sms_token(cellphone))
      result res.body
    end

    def result(body)
      code = body.match(/.+error>(.+)\<\/error/)[1]
      {
        success: (code.to_i >= 0),
        code: code
      }
    end

    def sms_token(cellphone)

      #verification_code = Random.rand(100000...999999)
      verification_token = RandomCode.generate_cellphone_token(6)
      $redis.set("#{cellphone}_token_key", verification_token)
      $redis.expire("#{cellphone}_token_key", 600)
      content = "#{MESSAGE_SUFFIX}你本次的短信验证码是#{verification_token}，聪明的人都会立马使用它哦。"
      return(content)
    end
  end
end
