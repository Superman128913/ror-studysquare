class PaymentsController < ApplicationController
  # Called by Buckaroo
  def create
    params = {}
    request.filtered_parameters.symbolize_keys.each do |k, v|
      params.merge! k.downcase => v
    end

    buckaroo_response = Buckaroo::Ideal::Response.new params
    status = buckaroo_response.status

    @order = Order.find(buckaroo_response.invoice_number)
    @order.payed ||= status.completed?

    sign_in :user, @order.customer

    if status.pending?
      return redirect_to orders_url, notice: "De betaling wordt gecontroleerd. Je ontvangt een bevestiging per e-mail als de betaling geslaagd is."
    end

    if @order.payed?
      @order.save!
      redirect_to orders_url, notice: "Betaling geslaagd"
    else
      @order.destroy if status.code.to_i == 890 # User cancellation
      @order = nil
      redirect_to orders_url, alert: "Betaling mislukt"
    end
  end
end

