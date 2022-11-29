class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :group
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.integer :capacity, default: 0
      t.boolean :visible, default: false
      t.references :program_course
      t.references :tutor

      t.timestamps
    end
    add_index :courses, :program_course_id
  end
end
