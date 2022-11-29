class CreateProgramCourses < ActiveRecord::Migration
  def change
    create_table :program_courses do |t|
      t.string :name
      t.string :acronym
      t.integer :year
      t.references :faculty_program

      t.timestamps
    end
    add_index :program_courses, :faculty_program_id
  end
end
