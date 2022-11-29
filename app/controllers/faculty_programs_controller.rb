class FacultyProgramsController < InheritedResources::Base
  actions :index
  belongs_to :institute
  belongs_to :faculty

  def index
    index! { return render 'courses/index' }
  end

  def show
    redirect_to new_manager_message_path(type: FacultyProgram, id: params[:id])
  end
end
