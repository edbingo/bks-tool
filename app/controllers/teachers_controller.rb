class TeachersController < ApplicationController
  def list
    @teacher = Teacher.all.order(:name)
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

  private
  def teacher_params
    params.require(:teacher).permit(:name,:mail)
  end

end
