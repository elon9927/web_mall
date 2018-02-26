class Admin::SessionsController < Admin::BaseController

  before_action :highlight_tab
  skip_before_action :auth_admin, only: [:new]
  def new
  end

  def destroy
    logout
    cookies.delete :user_uuid
    flash[:notice] = "退出成功"
    redirect_to root_path
  end

  private
  def highlight_tab
    @tab = "home"
  end
end
