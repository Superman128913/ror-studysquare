class Manager::RegistrationsController < Manager::ManagerController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: "Geen toegang"
  end

  def index
    @registrations = @registrations.where('updated_at > ?', Time.now - 1.week).order('id DESC').includes(course: [:course_type, :program_course]).includes(:customer)
    @revenue_last_week = @registrations.map(&:price).inject(:+)
  end
end

