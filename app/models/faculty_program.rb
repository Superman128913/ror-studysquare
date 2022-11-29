class FacultyProgram < ActiveRecord::Base
  has_paper_trail

  belongs_to :faculty
  has_one :institute, through: :faculty

  has_and_belongs_to_many :program_courses

  alias_method :parent, :faculty

  has_many :courses, through: :program_courses
  has_many :customers

  has_many :messages, as: :messageable

  attr_accessible :acronym, :name, :faculty_id, as: :admin
  validates_presence_of :acronym, :name, :faculty

  def revenue(date)
    program_courses.collect {|p| p.revenue(date) }.compact.inject(:+)
  end

  def to_s
    acronym
  end

  def description
    acronym + " (#{faculty.acronym}-#{faculty.institute.acronym})" if valid?
  end

  def to_param
    [id, acronym].join('-').downcase
  end

  protected

  rails_admin do
    visible false
    parent Institute

    field :name
    field :acronym
    field :faculty
    field :program_courses

    list do
      exclude_fields :program_courses
    end
  end
end

