require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in :user, users(:pepijn)
    @order = orders(:was)
    @order.payed = true
    @order.save
  end

  test "should show my studysquare" do
    get :index
    assert_response :success
  end

  test "should redirect unless shopping cart exists" do
    get :new
    assert_redirected_to institutes_path
  end

  test "should show new order page if shopping cart exists" do
    get :new, nil, { cart: Cart.new }
    assert_response :success
  end

  test "redirect to invoice pdf" do
    get :show, id: @order
    assert_redirected_to order_path(@order, format: :pdf)
  end

  test "show invoice pdf" do
    get :show, id: @order, format: :pdf
    assert_response :success
  end

  test "should redirect to root on cart nil/expired" do
    post :create
    assert_response :redirect
  end
end

