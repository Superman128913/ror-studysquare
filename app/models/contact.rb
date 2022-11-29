class Contact < MailForm::Base
  attribute :name
  attribute :email
  attribute :telephone
  attribute :high_school
  attribute :niveau
  attribute :program_courses
  attribute :nickname,    :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Examen Trainingen",
      :to => "examentraining@studysquare.nl",
      :from => %("#{name}" <#{email}>),
    }
  end
end