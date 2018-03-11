class UsersController < ApplicationController
  def new; @user = User.new; end
  def create
    @user = User.new(user_params)
    @user.user_group_id = UserGroup.find_by(group_name: "customer").id
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:registration_failed] = "Registration failed."
      redirect_to '/signup' 
    end
  end
  def show; end
  private
  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
