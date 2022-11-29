class Customer < User
  has_many :orders, inverse_of: :customer
  has_many :registrations, inverse_of: :customer
  has_many :courses, through: :registrations
  has_many :timeslots, through: :courses

  protected

  rails_admin do
    visible true
    navigation_label "Manager"

    list do
      field :id
      field :first_name
      field :last_name
      field :email
      field :updated_at
    end

    show do
      field :name

      field :email
      field :telephone

      field :address_1
      field :address_2

      field :institute
      field :faculty
      field :faculty_program
      field :student_number

      field :registrations
      field :courses
      field :orders
    end

    edit do
      exclude_fields :reset_password_sent_at, :remember_created_at,
        :sign_in_count, :current_sign_in_at, :last_sign_in_at,
        :current_sign_in_ip, :last_sign_in_ip, :orders, :registrations,
        :courses, :timeslots
    end
  end
end

