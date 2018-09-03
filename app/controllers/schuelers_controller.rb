class SchuelersController < ApplicationController
  before_action :logged_in_stud, only: [:show, :new, :import, :list, :create]
  def new
    @schueler = Schueler.new
  end

  def show
    @schueler = Schueler.find(params[:id])
  end

  def create
    @schueler = Schueler.new(schueler_params)
    if @schueler.save
      flash[:success] = "User successfully registered"
      redirect_to @schueler
    else
      render 'new'
    end
  end

  def import
    Schueler.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Students added successfully"
  end

  def list
    @student = Schueler.all
  end

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Administrator zugänglich"
      redirect_to admin_login_path
    end
  end

  private

    def schueler_params
      params.require(:schueler).permit(:Vorname, :Name, :Mail, :Klasse, :Number,:password,:password_confirmation)
    end
end
