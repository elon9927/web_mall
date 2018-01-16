class HomeController < ApplicationController
  def index
    @time = Time.now.strftime('%F-%T')
    #@time = Time.now.strftime("%H:%M:%S")
  end
end
