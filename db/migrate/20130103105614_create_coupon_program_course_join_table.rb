class CreateCouponProgramCourseJoinTable < ActiveRecord::Migration
  def change
    create_table :coupons_program_courses, :id => false do |t|
      t.references :coupon
      t.references :program_course
    end
  end
end

