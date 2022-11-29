class CreateFacultyProgramCourses < ActiveRecord::Migration
  def change
    create_table :faculty_program_courses do |t|
      t.references :faculty_program
      t.references :program_course

      t.timestamps
    end
    add_index :faculty_program_courses, :faculty_program_id
    add_index :faculty_program_courses, :program_course_id

    remove_column :program_courses, :faculty_program_id
  end
end
