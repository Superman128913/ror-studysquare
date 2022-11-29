class Order < ActiveRecord::Base
  has_paper_trail

  serialize :cart_course_ids, Array

  has_many :registrations, inverse_of: :order, dependent: :destroy
  has_many :courses, through: :registrations
  belongs_to :coupon, touch: true

  belongs_to :customer, inverse_of: :orders

  attr_accessible :payed, as: :admin
  validates_presence_of :customer

  before_save :create_registrations

  default_scope -> { includes(:courses, :coupon) }
  scope :coupon, lambda { |coupon| where(coupon_id: coupon) }

  def to_s
    "##{id}"
  end

  def total
    registrations.collect(&:price).inject(:+) or 0
  end

  def import_cart(cart)
    self.coupon = cart.coupon
    self.cart_course_ids = cart.course_ids
  end

  protected

  def create_registrations
    if payed_changed? and payed?
      cart_course_ids.each do |course_id|
        course = Course.find course_id

        registration = registrations.build
        registration.coupon = coupon
        registration.course = course

        registrations << registration
      end
    end
  end

  rails_admin do
    navigation_label "Manager"
    weight 2

    field :id
    field :payed
    field :total do
      pretty_value do
        ActionController::Base.helpers.number_to_currency value
      end
    end
    field :customer
    field :coupon
    field :courses

    list do
      exclude_fields :coupon
    end

    show do
      field :updated_at
    end
  end
end

