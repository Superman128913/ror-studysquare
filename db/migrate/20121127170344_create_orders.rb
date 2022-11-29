class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :payed, default: false
      t.text :cart_course_ids
      t.references :user
      t.references :coupon

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
