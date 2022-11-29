class SwitchToCourseTypes < ActiveRecord::Migration
  def change
    remove_column :courses, :name
    add_column :course_types, :description, :text
  end
end

