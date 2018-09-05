class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.password_mail.subject
  #
  def password_mail(student)
    @student = student
    mail to: student.Mail, subject: "MA19 - Elektronische Anmeldung"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.catchup_mail.subject
  #
  def catchup_mail(student)
    @student = student
    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.final_mail.subject
  #
  def final_mail(student)
    @student = student
    mail to: "to@example.org"
  end
end
