class InstitutesController < InheritedResources::Base
  actions :index

  def index
    @courses = Course
    # @courses = @courses.includes program_course: { faculty_programs: :institute }
    # @courses = @courses.includes(:program_course).where('')
    # @courses = @courses.where(visible: 'false')
    @courses = @courses.includes program_course: { faculty_programs: :institute }
   
    @filter_1 = "Universiteit/Hogeschool"
    @filter_2 = "Faculteit"
    @filter_3 = "Opleiding"
    @filter_4 = "Vak"

    if params[:type] == 'scholier'
      @courses = @courses.eager_load(program_course: {faculty_programs: :institute}).where('institutes.level = ?', 'MS')
      @filter_1 = "Middelbare school"
      @filter_2 = "Niveau"
      @filter_3 = "Jaar"
      @filter_4 = "Vak"
    end

    if params[:type] == 'student'
      @courses = @courses.eager_load(program_course: {faculty_programs: :institute}).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')
    end
    


    index! { render 'courses/index' and return }
  end
end
