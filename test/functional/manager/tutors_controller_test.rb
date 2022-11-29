require_relative 'manager_test'

class Manager::TutorsControllerTest < Manager::ManagerTest
  test "tutors index" do
    get :index
    assert_response :success
  end
end

