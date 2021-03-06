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
    mail to: @student.Mail, subject: "Gewählte Präsentationen"
  end

  def list_mail(teacher) # Sends teachers list of their presentations and list of attendants
    @teacher = teacher
    @presentations = Presentation.where(Betreuer: @teacher.Number)
    attachments["#{teacher.Vorname}_#{teacher.Name}_praesenzliste.pdf"] = generate_pdf(teacher,@presentations)
    mail to: @teacher.Mail, subject: "Definitive Schülerliste"
  end

  private

  def generate_pdf(teac,pres)
    @pres = Presentation.where(Betreuer: teac.Number)
    Prawn::Document.new(:page_size => "A4", :page_layout => :landscape) do
      text "#{teac.Vorname} #{teac.Name}", align: :center
      text "Ihre Präsentationen"
      table([
        ["Vorname","Name","Titel","Zimmer","Zeit"],
        [pres.collect{ |r| [r.Vorname] },
         pres.collect{ |r| [r.Name] },
         pres.collect{ |r| [r.Titel.truncate(80)] },
         pres.collect{ |r| [r.Zimmer] },
         pres.collect{ |r| [Time.at(r.Von.to_i).utc.strftime("%H:%M")] }]
        ])
      move_down 20
      pres.each do |pres|
        text "Besucher bei '#{pres.Titel}':"
        text "#{pres.Besucher}"
        move_down 20
      end
    end.render
  end

end
