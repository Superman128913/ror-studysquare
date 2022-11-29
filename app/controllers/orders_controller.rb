class OrdersController < ApplicationController
  before_filter :authenticate_user!, except: :new
  layout false, only: :create

  def index
    @orders = Order.joins(:registrations).where(registrations:
      { customer_id: current_user })
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.customer

    if @user != current_user && !current_user.role?(:admin)
      redirect_to orders_url, alert: "Niet gerechtigd"
    end

    @registrations = @order.registrations

    respond_to do |mime|
      mime.html { redirect_to format: :pdf }
      mime.pdf
    end
  end

  def new
    @cart = session[:cart]

    return redirect_to institutes_path,
      alert: "Sessie verlopen, bestel je cursus opnieuw" unless @cart
    @cart.coupon_id = nil # reset just in case a new (invalid) coupon is added

    if coupon = params[:coupon]
      coupon = Coupon.code(coupon[:code].upcase)

      unless coupon
        return redirect_to new_order_url, alert: "Coupon niet gevonden"
      end

      case coupon.validate_with_cart(@cart)
      when :valid
        @cart.coupon_id = coupon.id
        flash.now[:success] = "Coupon met #{@cart.coupon.discount}% korting toegevoegd aan je bestelling"
      when :course_type
        flash.now[:error] = "Coupon ongeldig voor dit type cursus"
      when :program_course
        flash.now[:error] = "Coupon ongeldig voor dit vak"
      when :expired
        flash.now[:error] = "Coupon verlopen"
      when :limit
        flash.now[:error] = "Coupon verlopen"
      else
        flash.now[:error] = "Coupon niet gevonden"
      end
    end
  end

  def create
    return redirect_to root_url,
      alert: "Alleen een klant kan bestellen" if current_user.role? :tutor

    return redirect_to root_url,
      alert: "Je sessie is verlopen, probeer de bestelling opnieuw aan te maken" unless session[:cart]

    amount = session[:cart].total_payment

    @order = current_user.orders.build
    @order.import_cart session[:cart]
    @order.payed = true if amount == 0
    @order.save!

    if @order.payed?
      session[:cart] = nil
      redirect_to orders_url, notice: "Bestelling succesvol"
    else
      buckaroo_order = Buckaroo::Ideal::Order.new(
        ideal_issuer: params[:issuer],
        amount: amount,
        invoice_number: @order.id,
        success_url: payments_url,
        reject_url: payments_url
      )
      @request = Buckaroo::Ideal::Request.new buckaroo_order
    end
  end
end

