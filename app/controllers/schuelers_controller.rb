class SchuelersController < ApplicationController
  before_action :logged_in_stud, only: [:new, :import, :list, :create]
  def new
    @schueler = Schueler.new
  end

  def show
    @schueler = Schueler.find_by(id: session[:student_id])
    if @schueler.Selected == nil && @schueler.Selected1 == nil && @schueler.Selected2 == nil
      redirect_to error_path
    else
      @pres0 = Presentation.find_by(Titel: @schueler.Selected)
      @pres1 = Presentation.find_by(Titel: @schueler.Selected1)
      @pres2 = Presentation.find_by(Titel: @schueler.Selected2)
    end
  end

  def confirm
    @schueler = Schueler.find_by(id: session[:student_id])
    @pres0 = Presentation.find_by(Titel: @schueler.Selected)
    @pres1 = Presentation.find_by(Titel: @schueler.Selected1)
    @pres2 = Presentation.find_by(Titel: @schueler.Selected2)
  end

  def delfromdb
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

  def sendfile
    schueler = Schueler.find_by(id: session[:student_id])
    schueler.update_attribute(:Registered, true)
    pres0 = Presentation.find_by(Titel: schueler.Selected)
    pres1 = Presentation.find_by(Titel: schueler.Selected1)
    pres2 = Presentation.find_by(Titel: schueler.Selected2)
    pres0.update_attribute(:Besucher, "#{pres0.Besucher}" + "#{schueler.Vorname} " + "#{schueler.Name},")
    StudentMailer.final_mail(schueler).deliver_now
    # Send email to teacher
    schueler.update_attribute(:Number, "User deactivated")
    studsend()
  end

  def create
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

  def import
    Schueler.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Students added successfully"
  end

  def list
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

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Administrator zugänglich"
      redirect_to admin_login_path
    end
  end

  private

    def schueler_params
      params.require(:schueler).permit(:Vorname, :Name, :Mail, :Klasse, :Number,
        :password,:password_confirmation)
    end
end
