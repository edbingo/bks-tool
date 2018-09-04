class StudMailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.stud_mail_mailer.password_delivery.subject
  #
  def password_delivery
    @student = student
    mail to: student.Mail, subject: "MA19 - Elektronische Anmeldung"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.stud_mail_mailer.pres_list.subject
  #
  def pres_list
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.stud_mail_mailer.nonactive_warning.subject
  #
  def nonactive_warning
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
