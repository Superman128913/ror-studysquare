require_relative 'manager_test'

class Manager::ProgramCoursesControllerTest < Manager::ManagerTest
  test "program_courses index" do
    get :index
    assert_response :success
  end
end

