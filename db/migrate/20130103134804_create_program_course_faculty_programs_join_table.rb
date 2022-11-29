class CreateProgramCourseFacultyProgramsJoinTable < ActiveRecord::Migration
  def change
    rename_table :faculty_program_courses, :faculty_programs_program_courses

    remove_column :faculty_programs_program_courses, :id
    remove_column :faculty_programs_program_courses, :created_at
    remove_column :faculty_programs_program_courses, :updated_at
  end
end

