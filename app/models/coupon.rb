class Coupon < ActiveRecord::Base
  has_paper_trail

  def kind_enum
    { Bedrag: "cash", Percentage: 'percentage' }
  end

  has_many :orders
  has_many :customers, through: :orders

  belongs_to :course_type
  has_and_belongs_to_many :program_courses
  attr_accessible :code, :amount, :kind, :max_uses, :program_course_ids,
    :course_type_id, :expires_at, as: :admin

  validates :code, presence: true, uniqueness: true
  validates_presence_of :amount, :kind, :max_uses
  validates :amount, numericality: {
    less_than_or_equal_to: 100, greater_than_or_equal_to: 0
  }, if: -> { kind == 'percentage' }
  validates :program_courses, presence: true

  default_value_for :max_uses, 1

  def self.code(value)
    where('UPPER(code) = ?', value).first
  end

  default_value_for :code do
    (0...20).map{65.+(rand(26)).chr}.join
  end

  def course_price(course)
    case kind.to_sym
    when :percentage
      course.price * (1 - amount / 100)
    when :cash
      course.price - amount
    else
      raise "No cash/percentage given for kind!"
    end
  end

  def discount
    amount.to_s + (kind == 'percentage' ? '%' : '')
  end

  def uses
    Order.coupon(self).count
  end

  def usage
    [uses, max_uses].join '/'
  end

  def to_s
    code
  end

  def valid_with_cart?(cart)
    validate_with_cart(cart) == :valid
  end

  def validate_with_cart(cart)
    return :limit if max_uses && max_uses - uses <= 0
    return :expired if expires_at && expires_at < Date.today

    courses = cart.courses
    if self.course_type
      return :course_type unless courses.collect(&:course_type).include? course_type
    end

    if self.program_courses.present?
      program_courses = courses.map(&:program_course)
      return :program_course if (program_courses - self.program_courses).present?
      return :program_course if (self.program_courses & program_courses).empty?
    end

    return :valid # nothing going on
  end

  protected

  rails_admin do
    parent Order

    field :code
    field :usage
    field :course_type
    field :discount
    field :expires_at
    field :program_courses
    field :updated_at

    list do
      exclude_fields :updated_at
    end

    show do
      field :orders
      field :customers
    end

    edit do
      field :kind
      field :amount
      field :max_uses

      exclude_fields :usage, :discount, :updated_at
    end

    update do
      exclude_fields :code, :discount
    end
  end
end
