class Registration < ActiveRecord::Base
  has_paper_trail

  include ActionView::Helpers::NumberHelper

  attr_accessor :coupon

  belongs_to :customer, inverse_of: :registrations
  belongs_to :order, inverse_of: :registrations
  belongs_to :course, inverse_of: :registrations, touch: true
  has_one :coupon, through: :order
  attr_accessible :course_id, :user_id, :discount, as: :admin
  validates_presence_of :customer, :course

  # Set customer
  before_validation do
    self.customer ||= order.customer if order
  end

  # Set price
  before_create do
    self.price = coupon ? coupon.course_price(course) : course.price
  end

  # Disassociate from order if cash
  before_save { self.order = nil if course.cash }

  # E-mail notification
  after_create { Notifications.delay.registration(id) }

  # Touch course when moving students and such
  before_update { course.touch }

  def to_s
    "##{id} - #{customer} (#{number_to_currency price})" if id
  end

  protected

  rails_admin do
    navigation_label "Manager"

    list do
      field :id
      field :customer
      field :course
      field :created_at
      field :price do
        pretty_value do
          ActionController::Base.helpers.number_to_currency value
        end
      end
    end
  end
end

