class Manager::ProgramCoursesController < Manager::ManagerController
  def index
    if current_user.role? :admin
      manager_id = params[:manager_id]
      @manager = Manager.where(id: manager_id).first

      @program_courses = @manager ? @manager.program_courses : ProgramCourse
    end

    @year = params[:year] ? params[:year].to_i : Date.today.year
    @month = params[:month] ? params[:month].to_i : Date.today.month
    @date = Date.new(@year, @month)

    @revenue, @cost, @profit = 0, 0, 0
  end
end

