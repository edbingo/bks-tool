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

  def list2 # Sorting functions for student selection database
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
    @pries = Presentation.find_by(id: @current_student.Selected).Bis
    @pries1 = Presentation.find_by(id: @current_student.Selected1).Bis
    @pries2 = Presentation.find_by(id: @current_student.Selected2).Bis
    array = [@pries, @pries1, @pries2]
    array.sort_by!(&:to_i)
    @pres0 = array[0]
    @pres1 = array[1]
    @pres2 = array[2]
  end

  def addtodb
    # Find current student based on Session ID
    @schueler = Schueler.find_by(id: session[:student_id])
    # Fills in first free slot in student database
    if @schueler.Selected == nil
      id = params[:id].to_s
      @schueler.update_attribute(:Selected, id)
      pres = Presentation.find_by(id: id)
      if pres.Frei == 0
        redirect_to studenten_waehlen_path
        flash[:danger] = "Keine freie Plätze mehr"
      else
        pres.update_attribute(:Frei, pres.Frei - 1)
      end
    elsif @schueler.Selected != nil && @schueler.Selected1 == nil
      id = params['id'].to_s
      @schueler.update_attribute(:Selected1, id)
      pres = Presentation.find_by(id: id)
      if pres.Frei == 0
        redirect_to studenten_waehlen_path
        flash[:danger] = "Keine freie Plätze mehr"
      else
        pres.update_attribute(:Frei, pres.Frei - 1)
      end
    elsif @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 == nil
      id = params['id'].to_s
      @schueler.update_attribute(:Selected2, id)
      pres = Presentation.find_by(id: id)
      if pres.Frei == 0
        redirect_to studenten_waehlen_path
        flash[:danger] = "Keine freie Plätze mehr"
      else
        pres.update_attribute(:Frei, pres.Frei - 1)
      end
    end
    if @schueler.Selected != nil && @schueler.Selected1 != nil && @schueler.Selected2 != nil
      redirect_to studenten_clean_path
    else
      redirect_to studenten_waehlen_path
    end
  end

  def weg # Function removes previous selection from DB
    @schueler = Schueler.find_by(id: session[:student_id])
    id = params[:id].to_s
    if id == @schueler.Selected
      @schueler.update_attribute(:Selected, nil)
      pres = Presentation.find_by(id: id)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
      redirect_to studenten_waehlen_path
    elsif id == @schueler.Selected1
      @schueler.update_attribute(:Selected1, nil)
      pres = Presentation.find_by(id: id)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
      redirect_to studenten_waehlen_path
    elsif id == @schueler.Selected2
      @schueler.update_attribute(:Selected2, nil)
      pres = Presentation.find_by(id: id)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
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
