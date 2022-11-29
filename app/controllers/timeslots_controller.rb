class TimeslotsController < ApplicationController
  respond_to :ics

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      @timeslots = user.timeslots
    else
      @timeslots = Timeslot
    end

    @timeslots = @timeslots.where("starts_at > '#{Time.now}'")

    respond_with @timeslots
  end
end
