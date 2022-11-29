class Course < ActiveRecord::Base
  has_paper_trail

  AVAILABILITIES = :full, :success, :warning, :error

  belongs_to :program_course

  belongs_to :tutor
  belongs_to :course_type, touch: true
  has_many :timeslots, inverse_of: :course, dependent: :destroy
  has_many :registrations, inverse_of: :course
  has_many :customers, through: :registrations
  has_many :orders, through: :registrations
  has_and_belongs_to_many :costs
  accepts_nested_attributes_for :timeslots

  has_many :messages, as: :messageable

  # Manager
  attr_accessible :program_course_id, :tutor_id, :course_type_id, :group, :cash,
    :details, :capacity, :timeslots_attributes, :visible, :active, :price, :turbo
  # Admin
  attr_accessible :price, :program_course_id, :timeslots_attributes,
    :tutor_id, :capacity, :group, :visible, :cost_ids, :cash, :turbo,
    :course_type_id, :active, :details, as: :admin
  validates_presence_of :price, :program_course_id, :capacity, :course_type
  validates_numericality_of :price

  scope :visible, -> { where(visible: true) }
  scope :active, -> { where(active: true) }
  scope :non_cash, -> { where cash: false }

  before_validation do
    self.visible = false if !active && active_changed?
    self.active = true if visible && visible_changed?
  end

  def description(acronym = false)
    buffer = []
    buffer << "##{id} - "
    buffer << course_type.name if course_type
    buffer << program_course.acronym if program_course
    buffer << "(Groep #{group})" if group && group.present?
    buffer.join ' '
  end

  def revenue
    registrations.collect(&:price).inject(:+) || 0
  end

  def cost
    costs.collect(&:price).inject(:+) || 0
  end

  def profit
    revenue - cost
  end

  def starts_at
    timeslots.present? ? timeslots.first.starts_at : Time.now
  end

  def ends_at
    timeslots.present? ? timeslots.last.starts_at : Time.now
  end

  def status
    return :future if Time.now < starts_at
    return :active if Time.now < ends_at
    return :finished
  end

  def real_availability
    return AVAILABILITIES[1] if percentage_occupied < 0.4
    return AVAILABILITIES[2] if percentage_occupied < 0.66
    return AVAILABILITIES.last if percentage_occupied < 1
    return AVAILABILITIES.first # full
  end

  def availability
    availability = real_availability

    return AVAILABILITIES.last if turbo && availability != :full
    return availability
  end

  def percentage_occupied
    registrations.length / capacity.to_f
  end

  def occupancy
    [registrations.length, capacity].join '/'
  end

  protected

  rails_admin do
    navigation_label "Manager"
    weight 1

    field :id
    field :program_course
    field :course_type
    field :group
    field :active do
      help "In overzicht voor tutors/managers"
    end
    field :visible do
      help "Op publieke site"
    end
    field :updated_at

    list do
      exclude_fields :updated_at
    end

    edit do
      exclude_fields :id, :updated_at
    end
  end
end

