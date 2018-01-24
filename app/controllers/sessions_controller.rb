class SessionsController < ApplicationController
  def new
  end

  def create
    if user = login(params[:email], params[:password])
      unless session[:user_uuid] == user.uuid
        carts = Cart.where user_uuid: session[:user_uuid]
        carts.each do |cart|
          cart.update_attribute :user_uuid, user.uuid
        end
      end
      update_browser_uuid user.uuid
      flash[:notice] = "登录成功"
      redirect_to root_path
    else
      flash[:notice] = "邮箱或者密码不正确"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    session[:user_uuid] = cookies['user_uuid']= nil
    flash[:notice] = "退出成功"
    redirect_to root_path
  end
end
