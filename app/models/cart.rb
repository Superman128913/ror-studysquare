class Cart
  attr_accessor :coupon_id, :course_ids

  def initialize
    self.course_ids = []
  end

  # Add a course to the cart
  def <<(course)
    course_ids.append(course)
    course_ids.uniq!
  end

  def courses
    Course.where(id: course_ids)
  end

  def subtotal
    courses.collect(&:price).inject(:+) || 0
  end

  def coupon
    Coupon.find coupon_id if coupon_id
  end

  def coupon_discount
    return 0 unless coupon
    subtotal - courses.map { |course| coupon.course_price(course) }.inject(:+) || 0
  end

  def total
    subtotal - coupon_discount
  end

  def cash_deduction
    courses.where(cash: true).map do |course|
      coupon ? coupon.course_price(course) : course.price
    end.inject(:+) || 0
  end

  def total_payment
    total - cash_deduction
  end
end
