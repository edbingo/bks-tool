class SessionsController < ApplicationController

  def new
  end

  def create
    mildstudestroy
    admin = Admin.find_by(number: params[:session][:number].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to admin_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def studcreate
    mildestroy
    schueler = Schueler.find_by(number: params[:session][:number].downcase)
    if schueler && schueler.authenticate(params[:session][:password])
      stud_in schueler
      redirect_to studenten_waehlen_path
    else
      flash.now[:danger] = "Benutzer name oder Passwort falsch"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def mildestroy
    log_out
  end

  def mildstudestroy
    log_out
  end

  def studdestroy
    stud_out
    redirect_to root_path
  end

end
