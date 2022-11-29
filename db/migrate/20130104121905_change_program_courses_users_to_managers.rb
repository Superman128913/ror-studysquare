class ChangeProgramCoursesUsersToManagers < ActiveRecord::Migration
  def change
    rename_table :program_courses_users, :managers_program_courses
    rename_column :managers_program_courses, :user_id, :manager_id
  end
end

