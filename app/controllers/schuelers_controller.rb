class SchuelersController < ApplicationController
  before_action :logged_in_stud, only: [:new, :import, :list, :create, :add,:new,]
  helper_method :sort_col, :sort_dir

  def new
    @schueler = Schueler.new
  end

  def setreq
    n = params[:req]
    Schueler.all.each do |s|
      s.req = n
    end
    redirect_to admin_add_presentations_path
  end

  def show
    @schueler = Schueler.find_by(id: session[:student_id]) # Called profile in interface
    if @schueler.selected.count = 0
      redirect_to error_path # If nothing has been selected, display relevant error page
    else # Sets variables required for showing list of presentations
      @pres = @schueler.selected
    end
  end

  def confirm # Resets the variables
    @schueler = Schueler.find_by(id: session[:student_id])
    @pres = @schueler.selected
  end

  def sendfile # Removes ability to log in and sends email with selected presentations
    schueler = Schueler.find_by(id: session[:student_id])
    schueler.selected.each do |p|
      pres = Presentation.find_by(id: p)
      pres.besucher.push(schueler.id)
    end
    StudentMailer.final_mail(schueler).deliver_now
    schueler["Registered"] = true
    flash[:success] = "Anmeldung verschickt"
    stud_out()
    redirect_to root_path
  end

  def choices
    @stud = Schueler.find_by(id: params[:id])
    @pres = @stud.selected
    if @stud.Registered == true
      render 'choices'
    else
      flash[:danger] = "Anmeldung noch nicht verschickt"
      redirect_to admin_show_students_path
    end
  end

  def create # Creates new student based on entered parameters
    @schueler = Schueler.new(schueler_params)
    if @schueler.save
      flash[:success] = "User successfully registered"
      @schueler.update_attribute(:Code, @schueler.password)
      @schueler.update_attribute(:Registered, false)
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def import # Tells rails how to import CSV
    Schueler.import(params[:file])
    flash[:success] = "Es wurden #{$numstud} Schüler importiert, es gab #{$errstud} Fehler"
    render 'setreq'
  end

  def list # Following functions sorts students
    @student = Schueler.order("#{sort_col} #{sort_dir}")
  end

  def edit
    id = params[:id]
    $newstud = Schueler.find_by(id: id)
  end

  def update
    ustud = Schueler.find_by(id: $newstud.id)
    ustud.update_attribute(:Vorname, params[:vorname])
    ustud.update_attribute(:Name, params[:name])
    ustud.update_attribute(:Klasse, params[:klasse])
    ustud.update_attribute(:Mail, params[:mail])
    ustud.update_attribute(:Number, params[:number])
    redirect_to admin_show_students_path
  end

  def deleter
    id = params[:id]
    Schueler.find_by(id: id).destroy
    redirect_to admin_show_students_path
    flash[:success] = "Schüler wurde erfolgreich entfernt"
  end

  def logged_in_stud # Stops students from accessing admin sites
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Administrator zugänglich"
      redirect_to admin_login_path
    end
  end

  def remove # Search function on student removal page
    @student = if params[:term]
      Schueler.where('Name LIKE ?', "%#{params[:term]}")
    else
      Schueler.all
    end
  end

  def stentf # Actually removes student from db
    num = params[:number]
    Schueler.find_by(Number: num).destroy
    redirect_to admin_path
    flash[:success] = "Schüler wurde erfolgreich entfernt"
  end

  private

    def schueler_params
      params.require(:schueler).permit(:Vorname, :Name, :Mail, :Klasse, :Number,
        :password,:password_confirmation,:term,:add)
    end

    def sortable_cols
      ["Vorname", "Name", "Klasse", "Mail", "Number", "Code", "Registered"]
    end

    def sort_col
      sortable_cols.include?(params[:col]) ? params[:col] : "Vorname"
    end

    def sort_dir
      %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
    end
end
