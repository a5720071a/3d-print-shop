class PaymentsController < ApplicationController
  before_action :require_user, :has_customer_privillege?
  protect_from_forgery with: :null_session
  def new; end
  def check
    charge = Omise::Charge.create({
      amount: 123_45,
      currency: "thb",
      card: params[:omiseToken]
    })
    if charge.paid
      # handle success
      @result = 'success'
    else
      # handle failure
      @result = charge.failure_code
    end
  end
end
