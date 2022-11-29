class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.role? :manager
      can :access, :rails_admin
      can :dashboard

      if user.role? :admin
        can :manage, [
          Admin, Institute, Faculty, FacultyScholier, FacultyStudent, FacultyProgram, FacultyProgramScholier, FacultyProgramStudent, ProgramCourse,
          ProgramCourseScholier, ProgramCourseStudent, Manager, Cost, Timeslot, Tutor, CourseType, Course, Coupon
        ]

        can [:read, :update, :export, :history, :show_in_app], [Order, Customer]
        can [:read, :create, :export, :history], Message
        can [:read, :destroy, :export, :history], Registration
        can [:read, :destroy], BackgroundJob
        can :read, StsqVersion

        return
      end

      if user.role? :manager
        can :read, Manager, id: user.id
        can :read, [Institute, Faculty, FacultyProgram]
        can :manage, Tutor
        can :index, CourseType

        program_course_ids = user.program_courses.pluck :id
        where = { program_courses: { id: program_course_ids }}

        course_ids = Course.joins(:program_course).
          where(where).pluck 'courses.id'
        coupon_ids = Coupon.joins(:program_courses).
          where(where).pluck 'coupons.id'

        timeslot_ids = Timeslot.joins(course: :program_course).
          where(where).pluck 'timeslots.id'
        registration_ids = Registration.joins(course: :program_course).
          where(where).pluck 'registrations.id'

        customer_ids = Customer.joins(registrations: { course: :program_course }).
          where(where).pluck 'users.id'
        order_ids = Order.joins(registrations: { course: :program_course }).
          where(where).pluck 'orders.id'

        can :manage, ProgramCourse, id: program_course_ids
        can :manage, Course, id: (course_ids << nil)
        can :manage, Timeslot, id: (timeslot_ids << nil)
        can [:read, :destroy, :export, :history], Registration, id: registration_ids
        can [:read, :update, :export, :history], Customer,
          id: customer_ids
        can [:read, :update, :export, :history, :show_in_app], Order,
          id: order_ids

        can [:read, :create, :update], Coupon, id: coupon_ids
        return
      end
    end

    if user.role? :tutor
      courses = Course.where(tutor_id: user.id)
      can [:read, :update, :show_in_app], Course, id: courses.collect(&:id)
    end
  end
end
