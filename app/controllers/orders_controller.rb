class OrdersController < ApplicationController
  before_action :require_user
  protect_from_forgery with: :null_session
  def new
    @model = Model.find_by_id(params[:model])
  end
end
