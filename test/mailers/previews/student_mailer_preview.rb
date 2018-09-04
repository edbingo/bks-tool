# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/password_mail
  def password_mail
    schueler = Schueler.first
    StudentMailer.password_mail(schueler)
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/catchup_mail
  def catchup_mail
    StudentMailer.catchup_mail
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/final_mail
  def final_mail
    student = Schueler.first
    StudentMailer.final_mail(student)
  end

end
