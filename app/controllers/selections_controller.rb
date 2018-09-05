class SelectionsController < ApplicationController
  before_action :logged_in_stud
  def new
  end

  def list
    @presentations = Presentation.all.order(:Name)
  end

  def listb
    @presentations = Presentation.all.order(:Betreuer)
  end

  def listf
    @presentations = Presentation.all.order(:Fach)
  end

  def listk
    @presentations = Presentation.all.order(:Klasse)
  end

  def listt
    @presentations = Presentation.all.order(:Titel)
  end

  def listv
    @presentations = Presentation.all.order(:Von)
  end

  def confirm
  end


  def addtodb
    # Find current student based on Session ID
    @schueler = Schueler.find_by(id: session[:student_id])
    if @schueler.Selected == nil
      title = params[:title]
      @schueler.update_attribute(:Selected, title)
      pres = Presentation.find_by(Titel: title)
      pres.update_attribute(:Frei, pres.Frei - 1)
      redirect_to studenten_waehlen_path
    elsif @schueler.Selected != nil && @schueler.Selected1 == nil
      title = params['title']
      @schueler.update_attribute(:Selected1, title)
      pres = Presentation.find_by(Titel: title)
      pres.update_attribute(:Frei, pres.Frei - 1)
      redirect_to studenten_waehlen_path
    elsif @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 == nil
      title = params['title']
      @schueler.update_attribute(:Selected2, title)
      pres = Presentation.find_by(Titel: title)
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

end
