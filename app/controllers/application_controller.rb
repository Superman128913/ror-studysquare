class ApplicationController < ActionController::Base
  protect_from_forgery

  layout lambda { |c| c.request.xhr? ? false : "application" }

  before_filter do
    request.env['REMOTE_USER'] == current_user.id if current_user
  end

  def after_sign_in_path_for(resource)
    if session[:cart]
      new_order_url
    elsif current_user.role? :tutor
      manager_courses_path
    else
      orders_url
    end
  rescue
    root_url
  end

  def after_sign_up_path_for(resource)
    orders_url
  end
end
