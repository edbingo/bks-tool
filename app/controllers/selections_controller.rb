class SelectionsController < ApplicationController
  before_action :logged_in_stud
  def new
  end
  def list
    @presentations = Presentation.all.order(:Name)
  end

  def confirm
  end

  def addtodb
    @schueler = Schueler.find_by(id: session[:student_id])
    if @schueler.Selected == nil
      prestitle = params[:commit]
      @schueler.update_attribute(:Selected, prestitle)
      pres = Presentation.find_by(Titel: prestitle)
      pres.update_attribute(:Frei, pres.Frei - 1)
      redirect_to studenten_waehlen_path
    elsif @schueler.Selected != nil && @schueler.Selected1 == nil
      prestitle = params[:commit]
      @schueler.update_attribute(:Selected1, prestitle)
      pres = Presentation.find_by(Titel: prestitle)
      pres.update_attribute(:Frei, pres.Frei - 1)
      redirect_to studenten_waehlen_path
    elsif @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 == nil
      prestitle = params[:commit]
      @schueler.update_attribute(:Selected2, prestitle)
      pres = Presentation.find_by(Titel: prestitle)
      pres.update_attribute(:Frei, pres.Frei - 1)
      redirect_to studenten_waehlen_path
    end
  end

  def logged_in_stud
    unless logged_stud?
      flash[:danger] = "Diese Seite ist nur für angemeldete Schüler zugänglich"
      redirect_to studenten_anmelden_path
    end
  end

  private

  def select_params
    params.require(:title)
  end

end
