class Faculty < ActiveRecord::Base
  has_paper_trail

  belongs_to :institute
  has_many :faculty_programs, dependent: :destroy
  has_many :courses, through: :faculty_programs
  has_many :customers

  has_many :messages, as: :messageable

  alias_method :parent, :institute
  alias_method :children, :faculty_programs

  attr_accessible :acronym, :name, :institute_id, as: :admin
  validates_presence_of :acronym, :name, :institute

  default_scope -> { order("#{table_name}.name ASC") }

  def revenue(date)
    faculty_programs.collect {|f| f.revenue(date) }.compact.inject(:+)
  end

  def to_s
    acronym
  end

  def description
    acronym + " (#{institute.acronym})" if valid?
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
    field :institute

    list do
      sort_by :institute, :name
    end
  end
end

