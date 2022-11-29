class CreateCourseTypes < ActiveRecord::Migration
  def change
    create_table :course_types do |t|
      t.string :name

      t.timestamps
    end

    change_table :courses do |t|
      t.references :course_type
    end

    change_table :coupons do |t|
      t.references :course_type
    end
  end
end
