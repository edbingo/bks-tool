class SelectionsController < ApplicationController
  before_action :logged_in_stud
  def new
  end
  def list
    @presentations = Presentation.all
  end

  def confirm
  end

  def addtodb

  end

  def logged_in_stud
    unless logged_stud?
      flash[:danger] = "Diese Seite ist nur für angemeldete Schüler zugänglich"
      redirect_to studenten_anmelden_path
    end
  end

  def select_params
    params_require(:choice)
  end
end
