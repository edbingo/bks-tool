class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.password_mail.subject
  #
  def password_mail(student)
    @student = student
    mail to: @student.Mail, subject: "MA19 - Elektronische Anmeldung"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.catchup_mail.subject
  #
  def catchup_mail(student)
    @student = student
    mail to: @student.Mail, subject: "WICHTIG: MA19 - Elektronische Anmeldung"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.final_mail.subject
  #
  def final_mail(student)
    @student = student
    mail to: @student.Mail, subject: "Gewählte Presentationen"
  end

  def list_mail(teacher)
    @teacher = teacher
    mail to: @teacher.Mail, subject: "Definitive Schülerliste"
  end
end
