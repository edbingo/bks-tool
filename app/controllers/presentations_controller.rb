class PresentationsController < ApplicationController
  before_action :logged_in_stud

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Admins verfügbar"
      redirect_to admin_login_path
    end
  end

  def list
    @presentations = Presentation.all.order(:Name)
  end

  def show
  end

  def import
    Presentation.import(params[:file]) # Import presentation from file parameters
    flash.now[:success] = "Präsentationen erfolgreich hinzugefügt"
    render 'addfree'
  end

  def addfree # Set available spaces per presentation
    number = params[:free]
    pres = Presentation.all
    pres.each do |num|
      num.update_attribute(:Frei, number)
    end
    redirect_to admin_path
    flash[:success] = "Datenbank aktualisiert"
  end
end
