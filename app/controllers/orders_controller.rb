class OrdersController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new
    @model = Model.find_by id: params[:model]
    @filaments = Filament.all
  end
end
