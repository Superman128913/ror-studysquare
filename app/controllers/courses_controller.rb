class CoursesController < InheritedResources::Base
  actions :index, :show, :edit, :update
  belongs_to :institute, :faculty, :faculty_program, :program_course,
    optional: true

  def show
    show! { return redirect_to manager_course_path(@course) }
  end
end

