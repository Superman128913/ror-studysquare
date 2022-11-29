require 'test_helper'

class Manager::ManagerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in :user, users(:marlon)
  end
end

