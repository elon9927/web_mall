class Admin::ProductsController < Admin::BaseController

  before_action :find_product, only: [:edit, :update, :destroy]
  before_action :find_root_categories, only: [:new, :create, :edit, :update]
  before_action :highlight_tab
  def index

    @products = Product.page(params[:page] || 1).per(params[:per_page] || 10).order(id: "desc")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:notice] = "商品创建成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "商品创建失败"
      render :new
    end
  end

  def edit
    render :new
  end

  def update
    @product.attributes = product_params
    if @product.save
      flash[:notice] = "商品修改成功"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "删除失败"
      redirect_back(fallback_location: admin_products_path)
    end
  end

  private
  def product_params
    params.require(:product).permit!
  end

  def find_product
    @product = Product.find params[:id]
  end

  def find_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def highlight_tab
    @tab = 'product'
  end
end
