class Tutor < User
  has_many :courses
  has_many :timeslots, through: :courses

  def billable_hours(date)
    timeslots.month(date).collect(&:duration_in_hours).inject(:+)
  end

  protected

  rails_admin do
    parent Course

    list do
      field :id
      field :first_name
      field :last_name
      field :email
      field :updated_at
    end

    show do
      exclude_fields :courses, :timeslots
    end

    edit do
      exclude_fields :courses, :timeslots, :updated_at
    end
  end
end

