class Manager::MessagesController < Manager::ManagerController
  skip_authorize_resource

  def new
    @message = current_user.messages.build(
      messageable_type: params[:type],
      messageable_id: params[:id],
    )
    @message.user = current_user
    authorize! :show_in_app, @message.messageable
  end

  def create
    @message = current_user.messages.build(params[:message])

    # Load and authorize the resource that's being edited
    authorize! :show_in_app, @message.messageable

    if @message.save
      count = @message.customers.count
      redirect_to manager_courses_path,
        notice: "E-mail wordt uitgestuurd naar #{count} klanten"
    else
      render :new
    end
  end
end
