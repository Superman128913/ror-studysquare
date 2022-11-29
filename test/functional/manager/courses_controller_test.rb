require_relative 'manager_test'

class Manager::CoursesControllerTest < Manager::ManagerTest
  test "courses index" do
    get :index
    assert_response :success
  end
end

