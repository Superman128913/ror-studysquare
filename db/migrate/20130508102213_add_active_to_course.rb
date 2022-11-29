class AddActiveToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :active, :boolean, default: true

    #Course.where('id < ?', 110).map {|c| c.active = false; c.save! }
  end
end

