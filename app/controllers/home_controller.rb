class HomeController < ApplicationController

  before_action :highlight_tab
  def index
    @time = Time.now.strftime('%F-%T')
    #@time = Time.now.strftime("%H:%M:%S")
  end

  private
  def highlight_tab
    @tab = "home"
  end
end
