class SchuelersController < ApplicationController
  before_action :logged_in_stud, only: [:new, :import, :list, :create, :add,:new,]
  def new
    @schueler = Schueler.new
  end

  def show
    @schueler = Schueler.find_by(id: session[:student_id]) # Called profile in interface
    if @schueler.Selected == nil && @schueler.Selected1 == nil && @schueler.Selected2 == nil
      redirect_to error_path # If nothing has been selected, display relevant error page
    else # Sets variables required for showing list of presentations
      @pres0 = Presentation.find_by(Titel: @schueler.Selected)
      @pres1 = Presentation.find_by(Titel: @schueler.Selected1)
      @pres2 = Presentation.find_by(Titel: @schueler.Selected2)
    end
  end

  def confirm # Resets the variables
    @schueler = Schueler.find_by(id: session[:student_id])
    @pres0 = Presentation.find_by(Titel: @schueler.Selected)
    @pres1 = Presentation.find_by(Titel: @schueler.Selected1)
    @pres2 = Presentation.find_by(Titel: @schueler.Selected2)
  end

  def delfromdb # Function removes previous selection from DB
    @schueler = Schueler.find_by(id: session[:student_id])
    title = params[:title]
    if params[:title] == @schueler.Selected
      @schueler.update_attribute(:Selected, nil)
      pres = Presentation.find_by(Titel: title)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
      redirect_to studenten_waehlen_path
    elsif params[:title] == @schueler.Selected1
      @schueler.update_attribute(:Selected1, nil)
      pres = Presentation.find_by(Titel: title)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
      redirect_to studenten_waehlen_path
    elsif params[:title] == @schueler.Selected2
      @schueler.update_attribute(:Selected2, nil)
      pres = Presentation.find_by(Titel: title)
      pres.Frei = pres.update_attribute(:Frei, pres.Frei + 1)
      redirect_to studenten_waehlen_path
    end
  end

  def sendfile # Removes ability to log in and sends email with selected presentations
    schueler = Schueler.find_by(id: session[:student_id])
    schueler.update_attribute(:Registered, true)
    pres0 = Presentation.find_by(Titel: schueler.Selected)
    pres1 = Presentation.find_by(Titel: schueler.Selected1)
    pres2 = Presentation.find_by(Titel: schueler.Selected2)
    pres0.update_attribute(:Besucher, "#{pres0.Besucher}" + "#{schueler.Vorname} " + "#{schueler.Name},")
    pres1.update_attribute(:Besucher, "#{pres0.Besucher}" + "#{schueler.Vorname} " + "#{schueler.Name},")
    pres2.update_attribute(:Besucher, "#{pres0.Besucher}" + "#{schueler.Vorname} " + "#{schueler.Name},")
    StudentMailer.final_mail(schueler).deliver_now
    studsend()
  end

  def create # Creates new student based on entered parameters
    @schueler = Schueler.new(schueler_params)
    if @schueler.save
      flash[:success] = "User successfully registered, login details sent"
      @schueler.update_attribute(:Code, @schueler.password)
      @schueler.update_attribute(:Registered, false)
      StudentMailer.password_mail(@schueler).deliver_now
      redirect_to admin_path
    else
      render 'new'
    end
  end

  def import # Tells rails how to import CSV
    Schueler.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Students added successfully"
  end

  def list # Following functions sorts students
    @student = Schueler.all.order(:Name)
  end

  def listfn
    @student = Schueler.all.order(:Vorname)
  end

  def listkl
    @student = Schueler.all.order(:Klasse)
  end

  def listst
    @student = Schueler.all.order(:Registered)
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
end
