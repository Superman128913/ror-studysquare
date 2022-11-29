class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2, default: 0

      t.timestamps
    end

    create_table :costs_courses, :id => false do |t|
      t.references :course
      t.references :cost
    end

    add_index :costs_courses, [:course_id, :cost_id]
  end
end

