class Admin::UsersController < Admin::BaseController

  def set_role
    @user = User.find params[:id]
    @user.role = params[:role_id].to_i
    @user.save
  end
end
