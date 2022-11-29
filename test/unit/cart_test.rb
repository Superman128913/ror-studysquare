require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def assert_with_status(status)
    response = @coupon.validate_with_cart(@cart)
    assert_equal status, response

    if response == :valid
      assert @coupon.valid_with_cart?(@cart)
    else
      refute @coupon.valid_with_cart?(@cart)
    end
  end

  def setup
    @cart = Cart.new
    @cart << courses(:superstoom_was)
  end

  test "should be valid without course type and program courses within uses" do
    @coupon = coupons(:gratis)
    assert_with_status :valid
  end

  test "should return limit on use capacity" do
    @coupon = coupons(:in_use)
    assert_with_status :limit
  end

  test "should not use expired" do
    @coupon = coupons :expired
    assert_with_status :expired

    @coupon.expires_at = Date.today
    assert_with_status :valid

    @coupon.expires_at = Date.today + 5
    assert_with_status :valid
  end

  test "should return course type on course type mismatch" do
    @coupon = coupons('course_type')
    assert_with_status :course_type
  end

  test "should return program courses on program course mismatch" do
    @coupon = coupons('program_course')
    assert_with_status :program_course
  end
end

