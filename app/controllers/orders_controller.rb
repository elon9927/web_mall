class OrdersController < ApplicationController
  before_action :auth_user
  def new
    fetch_common_data
    @carts = Cart.by_user_uuid(current_user.uuid).order(id: 'desc')
      .includes(product: [:main_picture])
  end

  def create
    carts = Cart.by_user_uuid(current_user.uuid).includes(:product)
    if carts.blank?
      redirect_to carts_path
      return
    end

    address = current_user.addresses.find params[:address_id]
    order = Order.create_order_from_carts!(current_user, address, carts)
    redirect_to generate_pay_payments_path(order_no: order.order_no)
  end
end
