class ChangeIntegerToStringForCourseGroup < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.change :group, :string
    end
  end
end

