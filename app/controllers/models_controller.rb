class ModelsController < ApplicationController
  before_action :require_user
  protect_from_forgery with: :null_session
  def new
    @upload = Model.new
  end
  def upload
    @upload = Model.new(upload_params)
    @upload.share = "False"
    @upload.user_id = @current_user.id
    if @upload.save!
      redirect_to controller: "orders", action: "print_settings", model: "#{ @upload.id }"
    else
      redirect_to '/upload'
    end
  end
  private
  def upload_params
    params.require(:upload).permit(:model)
  end
end
