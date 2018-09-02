class SessionsStudController < ApplicationController
  def new
  end

  def create
    schueler = Schueler.find_by(number: params[:session][:number].downcase)
    if schueler && schueler.authenticate(params[:session][:password])
      stud_in schueler
      redirect_to schueler
    else
      flash.now[:danger] = "Benutzer name oder Passwort falsch"
      render 'new'
    end
  end

  def destroy
    stud_out
    redirect_to root_path
  end
end
