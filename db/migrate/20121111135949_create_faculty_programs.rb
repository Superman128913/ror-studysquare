class CreateFacultyPrograms < ActiveRecord::Migration
  def change
    create_table :faculty_programs do |t|
      t.string :name
      t.string :acronym
      t.references :faculty

      t.timestamps
    end
    add_index :faculty_programs, :faculty_id
  end
end
