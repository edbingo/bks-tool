class AdminsController < ApplicationController
  before_action :logged_in_stud

  def hub # Empty function
  end

  def new # Used in render 'new'
    @admin = Admin.new
  end

  def create # Add admin user to database
    @admin = Admin.new(admin_params) # Accepts user given parameters from page
    if @admin.save # If user presses submit
      flash[:success] = "Admin wurde registriert"
      redirect_to admin_path
    else # If user cancels
      render 'new'
    end
  end

  def list # Makes all admins available to the table
    @admin = Admin.all
  end

  def remove # Refactored code for searching the admin database
    @admin = if params[:term]
      Admin.where('Name LIKE ?', "%#{params[:term]}")
    else # If no search term is given, show all admins
      Admin.all
    end
  end

  def adent # Removes admin from db
    num = params[:number] # Receives admin number from page
    Admin.find_by(Number: num).destroy # Searches for selected admin by number, then destroys
    redirect_to admin_path
    flash[:success] = "Admin wurde erfolgreich entfernt"
  end

  def clear # Resets and seeds the database, also signs everyone out
    [Schueler, Admin, Presentation, Teacher].each { |model| model.truncate! }
    Rails.application.load_seed
    flash[:success] = "Datenbank wurde zurückgesetzt"
    redirect_to root_path
  end

  def logged_in_stud # Stops students from accessing admin sites
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Administrator zugänglich"
      redirect_to admin_login_path
    end
  end

  def logindetailssend # Sends all student class users an email with their login details
    stud = Schueler.all # Selects all students
    stud.each do |pupil| # Sends an email to each
      StudentMailer.password_mail(pupil).deliver_now
    end
    flash[:success] = "Login emails wurden versendet"
    redirect_to admin_path
  end

  def remindersend # Sends unregistered students a warning mail
    schueler = Schueler.all
    schueler.each do |pupil|
      unless pupil.Registered == true
        StudentMailer.catchup_mail(pupil).deliver_now
      end
    end
    flash[:success] = "Schüler wurden gemahnt"
    redirect_to admin_path
  end

  def finallistsend # Sends all teachers a list of their presentations and the guests
    teac = Teacher.all
    teac.each do |send|
      StudentMailer.list_mail(send).deliver_now
      send.update_attribute(:Received, true)
    end
    flash[:success] = "Presentationslisten wurden versendet"
    redirect_to admin_path
  end

  # Find all email templates and commands in the mailers folder

  private

  def admin_params # Tells rails which paramaters to accept
    params.require(:admin).permit(:name,:vorname,:mail,:number,:password,:password_confirmation,:term)
  end
end
