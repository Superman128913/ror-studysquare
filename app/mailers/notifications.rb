class Notifications < ActionMailer::Base
  default from: '"StudySquare" <postbode@studysquare.nl>'

  def generic_message(message_id, user_id)
    @message = Message.find(message_id)
    @user = User.find(user_id)

    from = @message.user ? "#{@message.user} <#{@message.user.email}>" : "StudySquare <postbode@studysquare.nl>"

    mail to: "#{@user.name} <#{@user.email}>",
         from: from,
         subject: @message.subject
  end

  def registration(registration_id)
    @registration = Registration.find(registration_id)
    @course = @registration.course
    @user = @registration.customer

    mail to: "#{@user.name} <#{@user.email}>",
         subject: "Bevestiging inschrijving: #{@course.description}"
  end

  def thankyou(name, email, telephone, high_school, niveau, program_courses)
    mail to: "#{name} <#{email}>",
         subject: "Bevestiging reservering examentraining",
         body: "Beste #{name}, bedankt voor je reservering voor onze examentrainingen.\n\n Zodra de examentrainingen voor de vakken die jij hebt aangegeven online komen, laten wij het jou weten!\nHieronder nog een overzicht van gegevens die jij hebt ingevuld:\n\nNaam: #{name}\nE-mail: #{email}\nTelefoonnummer: #{telephone}\nMiddelbare School: #{high_school}\nNiveau: #{niveau}\nVakken: #{program_courses}\n\nMocht er iets niet kloppen, laat het ons dan weten door een mail te sturen naar: examentraining@studysquare.nl."
  end
end

