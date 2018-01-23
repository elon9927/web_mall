class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def fetch_common_data
    @categories = Category.tree_data
  end
end
