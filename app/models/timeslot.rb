class Timeslot < ActiveRecord::Base
  has_paper_trail

  attr_accessor :duration

  belongs_to :course, touch: true, inverse_of: :timeslots
  has_one :tutor, through: :course, inverse_of: :timeslots
  has_one :program_course, through: :course

  attr_accessible :starts_at, :ends_at, :course_id, :location, :duration
  validates_presence_of :starts_at, :ends_at, :course_id

  default_scope order("#{table_name}.starts_at ASC")
  scope :month, lambda { |date|
    where('starts_at > ? AND ends_at < ?', Date.new(date.year, date.month),
          date.end_of_month)
  }

  before_validation do
    self.ends_at = starts_at + duration.to_f.hours if starts_at && duration
  end

  def description
    I18n.l starts_at, format: :date if valid?
  end

  def duration_in_hours
    (ends_at - starts_at) / 3600 # To hours
  end

  def to_s
    "#{I18n.l(starts_at, format: :short)} (#{duration_in_hours} uur)"
  end

  private

  rails_admin do
    parent Course

    field :starts_at
    field :ends_at
    field :location
    field :course
    field :tutor
  end
end

