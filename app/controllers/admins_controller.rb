class AdminsController < ApplicationController
  before_action :logged_in_stud
  def new
    @admin = Admin.new
  end

  def remove
    @admin = if params[:term]
      Admin.where('Name LIKE ?', "%#{params[:term]}")
    else
      Admin.all
    end
  end

  def adent
    num = params[:number]
    Admin.find_by(Number: num).destroy
    redirect_to admin_path
    flash[:success] = "Admin wurde erfolgreich entfernt"
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

  def logindetailssend
    stud = Schueler.all
    stud.each do |pupil|
      StudentMailer.password_mail(pupil).deliver_now
    end
    flash[:success] = "Login emails wurden versendet"
    redirect_to admin_path
  end

  def remindersend
    schueler = Schueler.all
    stud.each do |pupil|
      unless pupil.Registered == true
        StudentMailer.catchup_mail(pupil).deliver_now
      end
    end
    flash[:success] = "Schüler wurden gemahnt"
    redirect_to admin_path
  end

  def finallistsend
    teac = Teacher.all
    teac.each do |send|
      StudentMailer.list_mail(send).deliver_now
      send.update_attribute(:Received, true)
    end
    flash[:success] = "Presentationslisten wurden versendet"
    redirect_to admin_path
  end

  private

  def admin_params
    params.require(:admin).permit(:name,:vorname,:mail,:number,:password,:password_confirmation,:term)
  end
end
