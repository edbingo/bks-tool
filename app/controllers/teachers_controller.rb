class TeachersController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def list
    @teacher = Teacher.order("#{sort_col} #{sort_dir}")
  end

  def edit
    id = params[:id]
    $newteac = Teacher.find_by(id: id)
  end

  def pres
    id = params[:number]
    teac = Teacher.find_by(Number: id)
    @teaclist = Presentation.where(Betreuer: teac.Number)
    render 'preslist'
  end

  def update
    uteac = Teacher.find_by(id: $newteac.id)
    uteac.update_attribute(:Vorname, params[:vorname])
    uteac.update_attribute(:Name, params[:name])
    uteac.update_attribute(:Mail, params[:mail])
    uteac.update_attribute(:Number, params[:number])
    redirect_to admin_show_teachers_path
  end

  def deleter
    id = params[:id]
    Teacher.find_by(id: id).destroy
    redirect_to admin_show_teachers_path
    flash[:success] = "Lehrer wurde erfolgreich entfernt"
  end

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Admins verfügbar"
      redirect_to admin_login_path
    end
  end

  def new
    @teacher = Teacher.new
  end

  def import
    Teacher.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Lehrer erfolgreich hinzugefügt"
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash[:success] = "Lehrer wurde registriert"
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def remove
    @teacher = if params[:term]
      Teacher.where('Name LIKE ?', "%#{params[:term]}")
    else
      Teacher.all.order(:Name)
    end
  end

  def tentf
    num = params[:number]
    Teacher.find_by(Mail: num).destroy
    redirect_to admin_path
    flash[:success] = "Lehrer wurde erfolgreich entfernt"
  end

  private

  def teacher_params
    params.require(:teacher).permit(:Name,:Mail,:term,:id,:number)
  end

  def sortable_cols
    ["Vorname", "Name", "Mail", "Number"]
  end

  def sort_col
    sortable_cols.include?(params[:col]) ? params[:col] : "Vorname"
  end

  def sort_dir
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  end

end
