require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in :user, users(:pepijn)
  end
  
  test "should create registration for shopping cart" do
    post :create, course_id: courses(:superstoom_was)
    assert_response :success
  end

  test "should redirect to root unless cart" do
    delete :destroy, course_id: courses(:superstoom_was)
    assert_response :redirect
  end
end


