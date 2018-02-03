class Dashboard::BaseController < ApplicationController

  before_action :auth_user
  before_action :fetch_common_data
end
