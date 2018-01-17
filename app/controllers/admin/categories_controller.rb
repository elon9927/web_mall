class Admin::CategoriesController < Admin::BaseController

  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  def index
    if params[:id].blank?
      @categories = Category.roots
    else
      @root_category = Category.find params[:id]
      @categories = @root_category.children
    end
    @categories.page(params[:page] || 1).per(params[:per_page] || 10).order(id: "desc")
  end

  def new
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "保存成功"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    render :new
  end

  def update
    @category.attributes = category_params
    if @category.save
      flash[:notice] = "修改成功"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "删除失败"
      redirect_back(fallback_location: admin_categories_path)
    end
  end

  private
  def category_params
    params.require(:category).permit!
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end
end
