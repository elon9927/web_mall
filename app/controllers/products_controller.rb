class ProductsController < ApplicationController
  before_action :fetch_common_data
  def show
    @product = Product.find params[:id]
    @cart = Cart.find_by(product_id: params[:id], user_uuid: session[:user_uuid])
  end

  def search
    @products = Product.search_by_key(params[:key]).page(params[:page] || 1).per(params[:per_page] || 12).order(id: "desc").includes(:main_picture)

    unless params[:category_id].blank?
      @products = @products.where(category_id: params[:category_id])
    end

    render file: 'home/index'
  end
end
