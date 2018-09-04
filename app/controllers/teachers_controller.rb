class TeachersController < ApplicationController
  def list
    @teacher = Teacher.all.order(:name)
  end

  def import
    Teacher.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Lehrer erfolgreich hinzugefügt"    
  end
end
