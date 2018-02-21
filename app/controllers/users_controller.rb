class UsersController < ApplicationController
  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = (params[:user] and !params[:user][:email].nil?)
    @user = User.new(user_params)
    @user.uuid = session[:user_uuid]
    cellphone = params[:user][:cellphone]
    token = params["token"]
    if $redis.get("#{cellphone}_token_key") == token
      if @user.save
        auto_login(@user)
        flash[:notice] = "注册成功"
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:notice] = "验证码不正确或已过期"
      render :new
    end
  end

  def send_sms
    cellphone = params[:cellphone]
    unless cellphone =~ User::CELLPHONE_REG
      render json: {status: 'error', message: "手机号格式不正确！"}
      # render :status => 400, :plain => '手机格式不正确'
      return
    end
    unless User.exists?(cellphone: cellphone)
      SendSms.to(cellphone)
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: "手机号码已注册"}
      # render :status => 423, :plain => '手机号码已注册'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :cellphone)
  end
end
