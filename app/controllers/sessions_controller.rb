class SessionsController < ApplicationController
  def new
    @ref = params[:ref] if params[:ref]
  end
  def create
    @user = User.find_by username: params[:session][:username]
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      if params[:ref]
        redirect_to params[:ref]
      else
        redirect_to_home
      end
    else
      flash[:authentication_failed] = "Authentication failed."
      if params[:ref]
        redirect_to controller: "sessions", action: "new", ref: params[:ref]
      else
        redirect_to '/login'
      end
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
