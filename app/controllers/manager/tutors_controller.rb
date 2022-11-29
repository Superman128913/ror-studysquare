class Manager::TutorsController < Manager::ManagerController
  def index
    @year = params[:year] ? params[:year].to_i : Date.today.year
    @month = params[:month] ? params[:month].to_i : Date.today.month
    @date = Date.new(@year, @month)
  end
end

