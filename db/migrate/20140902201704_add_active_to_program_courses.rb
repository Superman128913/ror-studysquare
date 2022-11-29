class AddActiveToProgramCourses < ActiveRecord::Migration
  def change
    add_column :program_courses, :active, :boolean, default: true
    # ProgramCourse.all.each { |pc| pc.update_column :active, true }
  end
end
