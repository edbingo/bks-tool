class SelectionsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def new
  end

  def list # Sorting functions for student selection database
    if @current_student.selected.count == @current_student.req
      redirect_to studenten_clean_path
    else
      @presentations = Presentation.order("#{sort_col} #{sort_dir}")
    end
#    if @current_student.Selected != nil && @current_student.Selected1 != nil && @current_student.Selected2 != nil
#      redirect_to studenten_clean_path
#    else
#      @presentations = Presentation.order("#{sort_col} #{sort_dir}")
#    end
  end

#  def list2 # Sorting functions for student selection database
#    if @current_student.Selected != nil && @current_student.Selected1 != nil && @current_student.Selected2 != nil
#      redirect_to studenten_clean_path
#    else
#      @presentations = Presentation.order("#{sort_col} #{sort_dir}")
#    end
#  end

  def confirm
  end

  def addtodb
    # Find current student based on Session ID
    @schueler = Schueler.find_by(id: session[:student_id])
    id = params[:id]
    @pres = Presentation.find_by(id: id)
    @schueler.selected.push(@pres.id)
    @pres.Frei = @pres.Frei - 1
    byebug
    redirect_to studenten_waehlen_path
    byebug
  end

  def weg # Function removes previous selection from DB
    @schueler = Schueler.find_by(id: session[:student_id])
    id = params[:id]
    @schueler.delete(id)
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
