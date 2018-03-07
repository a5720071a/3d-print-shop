class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :is_customer?, :is_staff?, :is_admin?
  def home; end
  def current_user 
    @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  def require_user
    redirect_to controller: "sessions", action: "new", ref: "#{ request.original_url }" unless current_user
  end
  [:is_customer?, :is_staff?, :is_admin?].each do |method|
    define_method method do
      UserGroup.find_by(id: current_user.user_group_id).group_name == method.to_s[3..-2]
    end
  end
  def redirect_to_home
    if is_admin?
      redirect_to '/admin'
    elsif is_staff?
      redirect_to '/staff'
    else
      redirect_to '/'
    end
  end
  [:has_customer_privillege?, :has_staff_privillege?, :has_admin_privillege?].each do |method|
    define_method method do
      redirect_to_home unless UserGroup.find_by(id: current_user.user_group_id).group_name == method.to_s[4..-13]
    end
  end
end
