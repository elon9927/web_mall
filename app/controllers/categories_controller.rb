class CategoriesController < ApplicationController
  before_action :fetch_common_data
  def show
    @category = Category.find params[:id]
    @products = @category.products.onshelf.page(params[:page] || 1).per(params[:per_page] || 12).order(id: "desc").includes(:main_picture)
  end
end
