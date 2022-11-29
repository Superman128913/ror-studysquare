class AddExpiresAndCashToCoupons < ActiveRecord::Migration
  def change
    change_table :coupons do |t|
      t.string :kind
      t.date :expires_at
    end

    rename_column :coupons, :discount, :amount

    Coupon.all.each do |coupon|
      coupon.update_column :kind, :percentage
    end
  end
end

