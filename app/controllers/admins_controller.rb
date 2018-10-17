class AdminsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def hub
    if Presentation.first == nil && Teacher.first == nil && Schueler.first == nil
      redirect_to admin_setup_path
    elsif Presentation.first != nil && Teacher.first == nil && Schueler.first == nil
      redirect_to admin_add_students_path
    elsif Presentation.first != nil && Teacher.first == nil && Schueler.first != nil
      redirect_to admin_add_teachers_path
    end
    @dups = Array.new
    @n = 0
    Presentation.all.each do |row|
      if Presentation.where(Name: row.Name).count != 1 && Presentation.where(Titel: row.Titel).count != 1
        @dups << row.Titel
        @n = @n + 1
      end
    end
  end

  def deactivate
    stud = Schueler.all
    stud.each do |stud|
      stud.update_attribute(:loginpermit, false)
    end
    flash[:success] = "Anmeldungen deaktiviert"
    redirect_to admin_opt_path
  end

  def activate
    stud = Schueler.all
    stud.each do |stud|
      stud.update_attribute(:loginpermit, true)
    end
    flash[:success] = "Anmeldungen aktiviert"
    redirect_to admin_opt_path
  end

  def loginsend
    @student = Schueler.all
  end

  def new # Used in render 'new'
    @admin = Admin.new
  end

  def create # Add admin user to database
    @admin = Admin.new(admin_params) # Accepts user given parameters from page
    if @admin.save # If user presses submit
      flash[:success] = "Admin #{@admin.number} wurde registriert"
      redirect_to admin_path
    else # If user cancels
      render 'new'
    end
  end

  def list # Makes all admins available to the table
    @admn = Admin.order("#{sort_col} #{sort_dir}")
  end

  def edit
    id = params[:id]
    $newadmn = Admin.find_by(id: id)
  end

  def update
    uadmn = Admin.find_by(id: $newadmn.id)
    uadmn.update_attribute(:vorname, params[:vorname])
    uadmn.update_attribute(:name, params[:name])
    uadmn.update_attribute(:mail, params[:mail])
    uadmn.update_attribute(:number, params[:nummer])
    redirect_to admin_show_admins_path
  end

  def deleter
    id = params[:id]
    Admin.find_by(id: id).destroy
    redirect_to admin_show_admins_path
    flash[:success] = "Admin wurde erfolgreich entfernt"
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
    Schueler.all.each do |stud|
      StudentMailer.password_mail(stud).deliver_now
      stud.update_attribute(:Received, true)
    end
    flash[:success] = "Login emails wurden versendet"
    redirect_to admin_path
  end

  def remindersend # Sends unregistered students a warning mail
    schueler = Schueler.where(Registered: false)
    schueler.each do |pupil|
      StudentMailer.catchup_mail(pupil).deliver_now
    end
    flash[:success] = "Schüler wurden gemahnt"
    redirect_to admin_path
  end

  def finallistsend # Sends all teachers a list of their presentations and the guests
    teac = Teacher.all
    teac.each do |send|
      if Presentation.where(Betreuer: send.Number) == []
      else
        StudentMailer.list_mail(send).deliver_now
        send.update_attribute(:Received, true)
      end
    end
    flash[:success] = "Presentationslisten wurden versendet"
    redirect_to admin_path
  end

  def addfree
  end

  def addreq
  end

  def addtime
    time = params[:mins]
    Presentation.each do |row|
      row["time"] = (time + 15) * 60
    end
  end

  # Find all email templates and commands in the mailers folder

  private

  def admin_params # Tells rails which paramaters to accept
    params.require(:admin).permit(:name,:vorname,:mail,:number,:password,:password_confirmation,:term)
  end

  def sortable_cols
    ["Vorname", "Name", "Mail", "Number"]
  end

  def sort_col
    sortable_cols.include?(params[:col]) ? params[:col] : "Name"
  end

  def sort_dir
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  end
end
