class ChangeRegistrationToCustomer < ActiveRecord::Migration
  def change
    rename_column :registrations, :user_id, :customer_id
    rename_column :orders, :user_id, :customer_id
  end
end
