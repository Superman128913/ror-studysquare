class ProgramCoursesController < InheritedResources::Base
  actions :index
  belongs_to :institute
  belongs_to :faculty
  belongs_to :faculty_program

  def index
    index! { return render 'courses/index' }
  end
end

