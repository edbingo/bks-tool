# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/password_mail
  def password_mail
    student = Schueler.first
    StudentMailer.password_mail(student)
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/catchup_mail
  def catchup_mail
    student = Schueler.first
    StudentMailer.catchup_mail(student)
  end

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/final_mail
  def final_mail
    student = Schueler.first
    StudentMailer.final_mail(student)
  end

  def list_mail
    teacher = Teacher.find_by(Number: "l274")
    StudentMailer.list_mail(teacher)
    end
end
