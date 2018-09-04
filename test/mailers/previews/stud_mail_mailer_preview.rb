# Preview all emails at http://localhost:3000/rails/mailers/stud_mail_mailer
class StudMailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/stud_mail_mailer/password_delivery
  def password_delivery
    student = Schueler.first
  end

  # Preview this email at http://localhost:3000/rails/mailers/stud_mail_mailer/pres_list
  def pres_list
    StudMailMailer.pres_list
  end

  # Preview this email at http://localhost:3000/rails/mailers/stud_mail_mailer/nonactive_warning
  def nonactive_warning
    StudMailMailer.nonactive_warning
  end

end
