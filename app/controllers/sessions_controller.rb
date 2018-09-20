class SessionsController < ApplicationController

  def new
  end

  def newstud
  end

  def create # Creates session for admins
    admin = Admin.find_by(number: params[:session][:number].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to admin_path
    else
      flash.now[:danger] = 'Nummer oder Passwort inkorrekt'
      render 'new'
    end
  end

  def studcreate # Creates session for students
    schueler = Schueler.find_by(number: params[:session][:number].downcase)
    if schueler && schueler.authenticate(params[:session][:password]) && schueler.Registered == false
      stud_in schueler
      redirect_to studenten_waehlen_path
    elsif schueler && schueler.authenticate(params[:session][:password]) && schueler.Registered == true
      flash.now[:danger] = "Sie haben sich schon Registriert"
      render 'newstud'
    else
      flash.now[:danger] = "Nummer oder Passwort falsch"
      render 'newstud'
    end
  end

  def force
    stud = Schueler.find_by(Number: params[:number].downcase)
    stud_in stud
    redirect_to studenten_waehlen_path
  end


  def destroy # Destroys session for admins
    flash[:success] = "Erfolgreich abgemolden"
    log_out
    redirect_to root_url
  end

  def studdestroy # Destroys session for students
    flash[:success] = "Erfolgreich abgemolden"
    stud_out
    redirect_to root_path
  end

end
