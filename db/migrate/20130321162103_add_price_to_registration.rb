class AddPriceToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :price, :decimal,
      precision: 8, scale: 2, default: 0
  end
end

