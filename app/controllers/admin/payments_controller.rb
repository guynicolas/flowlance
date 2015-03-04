class Admin::PaymentsController < AdminController 
  before_filter :require_user
  def index
    @payments = Payment.all
  end
end 