class CartsController < ApplicationController

  before_action :find_cart, only: [:update, :destroy]

  def index
    fetch_common_data
    # TODO 购物车数量未异步更新
    @carts = Cart.by_user_uuid(session[:user_uuid]).order(id: 'desc')
      .includes(product: [:main_picture])
  end

  def create
    #TODO 完善从商品列表加入购物车与商品详情页加入购物车的amount逻辑处理
    amount = params[:amount].to_i
    amount = amount <= 0 ? 1 : amount
    @product = Product.find params[:product_id]
    @cart = Cart.create_or_update!({
      user_uuid: session[:user_uuid],
      product_id: params[:product_id],
      amount: amount
    })

    render layout: false
  end

  def update
    if @cart
      amount = params[:amount].to_i
      amount = amount <= 0 ? 1 : amount
      @cart.update_attribute :amount, amount
    end
    redirect_to carts_path
  end

  def destroy
    @cart.destroy if @cart
    redirect_to carts_path
  end

  private

  def find_cart
    @cart = Cart.by_user_uuid(session[:user_uuid]).find_by(id: params[:id])
  end
end
