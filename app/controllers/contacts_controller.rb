class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
    else
      flash.now[:error] = 'Cannot send message.'
    end
    Notifications.thankyou(@contact.name, @contact.email, @contact.telephone, @contact.high_school, 
                           @contact.niveau, @contact.program_courses).deliver
    redirect_to '/scholieren'
  end
end