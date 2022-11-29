class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.string :name
      t.string :acronym
      t.string :city
      t.string :level

      t.timestamps
    end
  end
end
