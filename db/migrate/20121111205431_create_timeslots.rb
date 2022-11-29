class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.string :location, default: ""
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :course

      t.timestamps
    end
    add_index :timeslots, :course_id
  end
end
