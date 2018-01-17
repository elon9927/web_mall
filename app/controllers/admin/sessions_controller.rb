class Admin::SessionsController < Admin::BaseController

  before_action :highlight_tab
  def new
  end

  private
  def highlight_tab
    @tab = "home"
  end
end
