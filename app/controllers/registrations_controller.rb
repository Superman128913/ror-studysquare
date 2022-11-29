class RegistrationsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    session[:cart] ||= Cart.new
    session[:cart] << @course.id
  end

  def destroy
    return redirect_to root_url,
      alert: "Je sessie is verlopen, probeer de bestelling opnieuw aan te maken" unless session[:cart]

    @course = Course.find(params[:course_id])
    session[:cart].course_ids.reject! {|id| id == @course.id }

    redirect_to :back
  end
end
