class UseSingleTableInheritance < ActiveRecord::Migration
  def change
    change_column_default :users, :role, nil

    User.all.each do |user|
      user.role = 'customer' if user.role == 'user'

      user.role = user.role.capitalize
      user.save!
    end

    rename_column :users, :role, :type
  end
end

