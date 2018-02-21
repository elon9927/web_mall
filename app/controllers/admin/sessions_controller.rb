class Admin::SessionsController < Admin::BaseController

  before_action :highlight_tab
  skip_before_action :auth_admin, only: [:new, :create]
  def new
  end

  def create
    if user = login(params[:email], params[:password])

      flash[:notice] = "管理员登录成功"
      redirect_to admin_root_path
    else
      flash[:notice] = "邮箱或者密码不正确"
      redirect_to new_admin_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = "退出成功"
    # cookis.delete :user
    redirect_to new_admin_session_path
  end

  private
  def highlight_tab
    @tab = "home"
  end
end
