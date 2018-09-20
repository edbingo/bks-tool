class PresentationsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(pres_params)
    if @presentation.save
      @presentation.update_attribute(:Frei, $number.to_f)
      flash[:success] = "Präsentation #{@presentation.Titel} gespeichert"
      redirect_to admin_show_presentations_path
    else
      render 'new'
    end
  end

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Admins verfügbar"
      redirect_to admin_login_path
    end
  end

  def list
    @pres = Presentation.order("#{sort_col} #{sort_dir}")
  end

  def edit
    id = params[:id]
    $newpres = Presentation.find_by(id: id)
  end

  def update
    upres = Presentation.find_by(id: $newpres.id)
    upres.update_attribute(:Klasse, params[:klasse])
    upres.update_attribute(:Name, params[:name])
    upres.update_attribute(:Titel, params[:title])
    upres.update_attribute(:Fach, params[:fach])
    upres.update_attribute(:Betreuer, params[:betreuer])
    upres.update_attribute(:Zimmer, params[:zimmer])
    upres.update_attribute(:Von, params[:von])
    upres.update_attribute(:Bis, params[:bis])
    redirect_to admin_show_presentations_path
  end

  def show
  end

  def import
    Presentation.import(params[:file]) # Import presentation from file parameters
    flash.now[:success] = "Präsentationen erfolgreich hinzugefügt"
    render 'addfree'
  end

  def addfree # Set available spaces per presentation
    $number = params[:free]
    pres = Presentation.all
    pres.each do |num|
      num.update_attribute(:Frei, $number)
    end
    redirect_to admin_path
    flash[:success] = "Datenbank aktualisiert"
  end

  def deleter
    id = params[:id]
    Presentation.find_by(id: id).destroy
    redirect_to admin_show_presentations_path
    flash[:success] = "Presentation wurde erfolgreich entfernt"
  end

  private

  def pres_params
    params.require(:presentation).permit(:Name,:Klasse,:Titel,:Fach,:Betreuer,:Zimmer,:Von,:Bis,:Datum)
  end

  def sortable_cols
    ["Name", "Klasse", "Titel", "Fach", "Betreuer", "Zimmer", "Von", "Frei"]
  end

  def sort_col
    sortable_cols.include?(params[:col]) ? params[:col] : "Name"
  end

  def sort_dir
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  end
end
