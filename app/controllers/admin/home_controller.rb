class Admin::HomeController < Admin::BaseController

  before_action :highlight_tab
  def index
    @users = User.page(params[:page] || 1).per(params[:per_page] || 10).order('id asc')
  end

  private
  def highlight_tab
    @tab = 'home'
  end
end
