require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = courses(:superstoom_was)
  end

  test "should be invisible when set inactive and visible on active" do
    assert @course.active
    assert @course.visible

    @course.active = false
    @course.save
    refute @course.active
    refute @course.visible

    @course.active = true
    @course.save
    assert @course.active
    refute @course.visible

    @course.active = false
    @course.save
    @course.visible = true
    @course.save
    assert @course.active
    assert @course.visible

    @course.visible = false
    @course.save
    assert @course.active
    refute @course.visible
  end
end
