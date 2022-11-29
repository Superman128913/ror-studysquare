class ProgramCourse < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :faculty_programs
  has_and_belongs_to_many :coupons
  has_and_belongs_to_many :managers

  has_many :courses, inverse_of: :program_course, dependent: :destroy
  has_many :timeslots, through: :courses
  has_many :customers

  attr_accessible :acronym, :name, :year, :faculty_program_ids, :coupon_ids,
    :manager_ids, :active, as: :admin
  validates_presence_of :acronym, :name, :year, :managers

  default_scope -> { order("#{table_name}.name ASC") }

  def to_s
    acronym
  end

  def to_param
    [id, acronym].join('-').gsub(/\W+/, '-').downcase
  end

  def courses_for(date)
    courses.non_cash.keep_if do |course|
      course.starts_at >= date.beginning_of_month &&
        course.starts_at <= date.end_of_month
    end
  end

  def revenue(date)
    courses_for(date).collect(&:revenue).inject(:+) || 0
  end

  def cost(date)
    courses_for(date).collect(&:cost).inject(:+) || 0
  end

  def profit(date)
    revenue(date) - cost(date)
  end

  def description
    "#{acronym} - #{name} (##{id})"
  end

  protected

  rails_admin do
    navigation_label "Manager"
    weight -2

    field :id
    field :name
    field :acronym
    field :year
    field :active
    field :faculty_programs
    field :managers
    field :courses
    field :coupons

    list do
      exclude_fields :acronym, :year, :courses, :coupons
    end

    edit do
      exclude_fields :courses
    end
  end
end

