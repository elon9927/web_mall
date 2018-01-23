class HomeController < ApplicationController

  before_action :highlight_tab
  def index
    fetch_common_data
    @products = Product.onshelf.page(params[:page] || 1).per(params[:per_page] || 12).order(id: "desc").includes(:main_picture)

  end

  private
  def highlight_tab
    @tab = "home"
  end
end
