class TeachersController < ApplicationController
  before_action :logged_in_stud
  def list
    @teacher = Teacher.all.order(:name)
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
    params.require(:teacher).permit(:Name,:Mail,:term)
  end

end
