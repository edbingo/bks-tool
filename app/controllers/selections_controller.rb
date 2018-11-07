class SelectionsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def new
  end

  def list # Sorting functions for student selection database
    if @current_student.selected.count.to_i = @current_student.req.to_i
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

  def clean
    @presentations = Presentation.order("#{sort_col} #{sort_dir}")
    @priev = Presentation.find_by(id: @current_student.Selected).Von
    @pries = Presentation.find_by(id: @current_student.Selected).Bis
    @priev1 = Presentation.find_by(id: @current_student.Selected1).Von
    @pries1 = Presentation.find_by(id: @current_student.Selected1).Bis
    @priev2 = Presentation.find_by(id: @current_student.Selected2).Von
    @pries2 = Presentation.find_by(id: @current_student.Selected2).Bis
    array = [@pries, @pries1, @pries2]
    arry2 = [@priev, @priev1, @priev2]
    array.sort_by!(&:to_i)
    arry2.sort_by!(&:to_i)
    @pres0 = array[0]
    @pres1 = array[1]
    @pres2 = array[2]
    @prev0 = arry2[0]
    @prev1 = arry2[1]
    @prev2 = arry2[2]
  end

  def addtodb
    # Find current student based on Session ID
    @schueler = Schueler.find_by(id: session[:student_id])
    @pres = Presentation.find_by(id: id)
    @schueler.selected.push(@pres.id)
    @pres.Frei = @pres.Frei - 1
  end

  def weg # Function removes previous selection from DB
    @schueler = Schueler.find_by(id: session[:student_id])
    id = params[:id].to_s
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
