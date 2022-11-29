class Institute < ActiveRecord::Base
  has_paper_trail

  def level_enum
    Studysquare::Settings::EDU_LEVELS
  end

  attr_accessible :acronym, :city, :name, :level, as: :admin
  validates_presence_of :city, :level
  validates :name, presence: true, uniqueness: true
  validates :acronym, presence: true, uniqueness: true

  has_many :faculties, dependent: :destroy
  has_many :courses, through: :faculties

  alias_method :children, :faculties

  has_many :messages, as: :messageable

  default_scope -> { order("#{table_name}.name ASC") }

  def to_s
    acronym
  end

  def type
    if level == 'MS'
      'scholier'
    else 
      'student'
    end
  end

  def description
    acronym
  end

  def to_param
    [id, acronym].join('-').downcase
  end

  protected

  rails_admin do
    navigation_label "Admin"
    weight 0

    field :name
    field :acronym
    field :city
    field :level

    show do
      field :faculties
    end
  end
end

