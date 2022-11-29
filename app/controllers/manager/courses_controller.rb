class Manager::CoursesController < Manager::ManagerController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to manager_courses_path, alert: "Geen toegang"
  end

  def index
    @resources = [Institute]
    @parents = []

    if current_user.role?(:admin) && params[:scope_type]
      type = params[:scope_type].constantize
      id = params[:scope_id].to_i
      resource = type.find(id)
      @courses = resource.courses

      @parents << resource

      while resource.respond_to?(:parent)
        resource = resource.parent
        @parents << resource
      end

      @parents.reverse.each do |parent|
        @resources << parent.children if parent.respond_to?(:children)
      end
    end

    @courses ||= Course
    @courses = @courses.includes program_course: { faculty_programs: :institute }

    if course_type_id = params[:course_type_id]
      @course_type = CourseType.find(course_type_id)
      @courses = @courses.where(course_type_id: @course_type)
    end

    models = %w(program_course registrations timeslots course_type)
    @courses = @courses.includes(models.map(&:to_sym))
    @courses = @courses.active.sort_by(&:starts_at)
  end

  def show
    @message = Message.new(messageable: @course)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new params[:course]

    if @course.save
      redirect_to [:manager, @course]
    else
      render :new
    end
  end

  def update
    if (registration_ids = params[:course][:registration_ids])
      @receiver = Course.where(id: params[:course][:id]).first

      registration_ids.reject do |id|
        id.to_i <= 0
      end
      @registrations = @course.registrations.find(registration_ids)

      @registrations.each do |registration|
        if @receiver
          registration.course = @receiver
          registration.save!
        else
          registration.destroy
        end
      end

      redirect_to [:manager, @course],
        notice: "#{@registrations.length} klant(en) succesvol overgeplaatst naar #{@receiver.description}"
    else
      if @course.update_attributes params[:course]
        redirect_to [:manager, @course], notice: "Cursus bijgewerkt en opgeslagen"
      else
        render :edit
      end
    end

  end
end

