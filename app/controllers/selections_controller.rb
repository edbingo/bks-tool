class SelectionsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def new
  end

  def list # Sorting functions for student selection database
    if @current_student.Selected != nil && @current_student.Selected1 != nil && @current_student.Selected2 != nil
      redirect_to studenten_clean_path
    else
      @presentations = Presentation.order("#{sort_col} #{sort_dir}")
    end
  end

  def confirm
  end

  def clean
    @presentations = Presentation.order("#{sort_col} #{sort_dir}")
  end

  def addtodb
    # Find current student based on Session ID
    @schueler = Schueler.find_by(id: session[:student_id])
    # Fills in first free slot in student database
    if @schueler.Selected == nil
      title = params[:title]
      @schueler.update_attribute(:Selected, title)
      pres = Presentation.find_by(Titel: title)
      pres.update_attribute(:Frei, pres.Frei - 1)
    elsif @schueler.Selected != nil && @schueler.Selected1 == nil
      title = params['title']
      @schueler.update_attribute(:Selected1, title)
      pres = Presentation.find_by(Titel: title)
      pres.update_attribute(:Frei, pres.Frei - 1)
    elsif @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 == nil
      title = params['title']
      @schueler.update_attribute(:Selected2, title)
      pres = Presentation.find_by(Titel: title)
      pres.update_attribute(:Frei, pres.Frei - 1)
    end
    if @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 != nil
      redirect_to studenten_clean_path
    else
      redirect_to studenten_waehlen_path
    end
  end

  def logged_in_stud # stops unregistered students from accessing select page
    unless logged_stud?
      flash[:danger] = "Diese Seite ist nur für angemeldete Schüler zugänglich"
      redirect_to studenten_anmelden_path
    end
  end

  private

  def sortable_cols
    ["Name", "Klasse", "Titel", "Fach", "Betreuer", "Zimmer", "Von", "Frei"]
  end

  def sort_col
    sortable_cols.include?(params[:col]) ? params[:col] : "Name"
  end

  def sort_dir
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  end

end
