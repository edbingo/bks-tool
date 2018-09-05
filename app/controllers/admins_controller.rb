class AdminsController < ApplicationController
  before_action :logged_in_stud
  def new
    @admin = Admin.new
  end

  def hub
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "Admin wurde registriert"
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def list
   @admin = Admin.all
  end


  def clear
    [Schueler, Admin, Presentation, Teacher].each { |model| model.truncate! }
    Rails.application.load_seed
    flash[:success] = "Datenbank wurde zurückgesetzt"
    redirect_to root_path
  end

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Administrator zugänglich"
      redirect_to admin_login_path
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name,:vorname,:mail,:number,:password,:password_confirmation)
  end
end
