class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references :user
      t.references :order
      t.references :course

      t.timestamps
    end
    add_index :registrations, :user_id
    add_index :registrations, :course_id
  end
end
