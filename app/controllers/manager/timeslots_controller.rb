class Manager::TimeslotsController < Manager::ManagerController
  def new
    @course = Course.find params[:course_id]
    @timeslot = @course.timeslots.build
  end

  def edit
    @timeslot = Timeslot.find params[:id]
    @course = @timeslot.course
  end 

  def create
    @timeslot = Timeslot.new params[:timeslot]
    @course = @timeslot.course

    if @timeslot.save
      redirect_to [:new, :manager, @course, :timeslot], notice: "Tijdvak toegevoegd en opgeslagen"
    else
      render :new
    end
  end

  def update
    @timeslot = Timeslot.find params[:id]

    if @timeslot.update_attributes params[:timeslot]
      redirect_to [:manager, @timeslot.course], notice: "Tijdvak bijgewerkt en opgeslagen"
    else
      render :edit
    end
  end

  def destroy
    @timeslot = Timeslot.find params[:id]

    if @timeslot.destroy
      redirect_to [:manager, @timeslot.course], notice: "Tijdvak verwijderd"
    end
  end
end

