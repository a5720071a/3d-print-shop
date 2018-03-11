class ModelsController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def index
    @models = Model.where share: true
  end
  def my_models
    @models = Model.where user_id: @current_user.id
  end
  def new
    @model = Model.new
  end
  def create
    @model = Model.new(model_params)
    @model.user_id = @current_user.id
    if @model.save!
      redirect_to controller: "items", action: "new", model: "#{ @model.id }"
    else
      redirect_to '/upload'
    end
  end
  private
  def model_params
    params.require(:model).permit(:model,:share)
  end
end
