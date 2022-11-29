class AddCashPaymentOptionToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :cash, :boolean
  end
end
