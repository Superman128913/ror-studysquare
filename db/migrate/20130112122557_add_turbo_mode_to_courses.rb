class AddTurboModeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :turbo, :boolean
  end
end
