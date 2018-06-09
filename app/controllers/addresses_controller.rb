class AddressesController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new
    @address = Address.new
    @postal_codes = PostalCode.all
  end
  def create
    @address = @current_user.addresses.new(get_address_params)
    if @address_book.save
      redirect_to '/checkout'
    else
      flash[:new_address_failed] = "Sorry, an error occured."
      redirect_to '/new_address' 
    end
  end
  private
  def get_address_params
    params.require(:address).permit(:description)
  end
end
