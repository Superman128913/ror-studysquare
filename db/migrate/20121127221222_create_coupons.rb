class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.decimal :discount, precision: 8, scale: 2, default: 0
      t.string :code
      t.integer :max_uses

      t.timestamps
    end
  end
end

