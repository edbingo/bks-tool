class SelectionsController < ApplicationController
  before_action :logged_in_stud
  def list
    @presentations = Presentation.all
  end

  def logged_in_stud
    unless logged_stud?
      flash[:danger] = "Diese Seite ist nur für angemeldete Schüler zugänglich"
      redirect_to studenten_anmelden_path
    end
  end
end
