class CreateProgramCourseTutorJoinTable < ActiveRecord::Migration
  def change
    create_table :program_courses_users, :id => false do |t|
      t.references :program_course
      t.references :user
    end

    add_index :program_courses_users, [:program_course_id, :user_id]

    # Forgot in the other migration
    add_index :coupons_program_courses, :coupon_id
    add_index :coupons_program_courses, :program_course_id
  end
end

