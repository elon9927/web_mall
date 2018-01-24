class HomeController < ApplicationController

  def index
    fetch_common_data
    @products = Product.onshelf.page(params[:page] || 1).per(params[:per_page] || 12).order(id: "desc").includes(:main_picture)

  end

  private

end
