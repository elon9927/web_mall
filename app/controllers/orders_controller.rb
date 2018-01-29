class OrdersController < ApplicationController
  before_action :auth_user
  def new
    fetch_common_data
  end
end
