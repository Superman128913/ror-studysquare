require 'test_helper'

class TimeslotsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in :user, users(:pepijn)
  end

  test "personal timetable" do
    get :index, format: :ics, user_id: users(:pepijn).id
    assert_response :success
  end
end

