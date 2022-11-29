require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @course = courses(:superstoom_was)
    @coupon = coupons(:test)

    build_order
  end

  test "should create order and registration" do
    assert @order.valid?
    assert @order.registrations.empty?

    assert_difference 'Registration.count' do
      pay
    end

    assert @order.registrations.present?
    @registration = @order.registrations.first

    assert_equal @course.price, @registration.price
  end

  test "should create order correctly with percentage coupon" do
    @order.coupon = @coupon

    pay

    @registration = @order.registrations.first

    refute_equal @registration.price, @course.price

    assert_equal 59.95, @course.price
    assert_equal 12.34, @coupon.amount
    assert_equal 'percentage', @coupon.kind
    assert_equal 52.55, @registration.price
  end

  test "should create order correctly with cash coupon" do
    @order.coupon = coupons :cash

    pay

    @registration = @order.registrations.first

    refute_equal @registration.price, @course.price

    assert_equal 59.95, @course.price
    assert_equal 20.00, @order.coupon.amount
    assert_equal 'cash', @order.coupon.kind
    assert_equal 39.95, @registration.price
  end

  test "should handle cash orders correctly" do
    @course = courses(:tweeweekse_stat1) # cash

    build_order

    assert_difference 'Registration.count' do
      pay
    end

    assert @order.registrations.empty?

    # Just get the last one, be careful
    @registration = Registration.last

    assert_equal @registration.price, @course.price
  end

  test "should create cash order correctly with coupon" do
    @course = courses(:tweeweekse_stat1) # cash
    build_order

    @order.coupon = @coupon

    pay

    @registration = Registration.last

    refute_equal @registration.price, @course.price

    assert_equal 99.95, @course.price
    assert_equal 12.34, @coupon.amount
    assert_equal 'percentage', @coupon.kind
    assert_equal 87.62, @registration.price
  end

  private

  def build_order
    @order = Order.new
    @order.cart_course_ids << @course.id
    @order.customer = users(:pepijn)
    @order.save
  end

  def pay
    @order.payed = true
    @order.save
  end
end

