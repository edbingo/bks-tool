class StudentMailer < ApplicationMailer

  def password_mail(student) # Sends mail with password and link
    @student = student
    mail to: @student.Mail, subject: "MA19 - Elektronische Anmeldung"
  end

  def catchup_mail(student) # Sends warning mail asking for users to sign in
    @student = student
    mail to: @student.Mail, subject: "WICHTIG: MA19 - Elektronische Anmeldung"
  end

  def final_mail(student) # Sends user their selected presentations
    @student = student
    mail to: @student.Mail, subject: "Gewählte Presentationen"
  end

  def list_mail(teacher) # Sends teachers list of their presentations and list of attendants
    @teacher = teacher
    mail to: @teacher.Mail, subject: "Definitive Schülerliste"
  end
end
