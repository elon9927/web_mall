class Dashboard::OrdersController < Dashboard::BaseController
  def index
    @orders = current_user.orders.page(params[:page] || 1).per(params[:per_page] || 12).order(id: "desc").includes(:address)
  end
end
