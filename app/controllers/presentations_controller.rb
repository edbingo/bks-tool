class PresentationsController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir

  def pres
    send_file(
      "#{Rails.root}/public/PresList.csv",
      filename: "Präsentationsliste.csv",
      type: "text/csv"
    )
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(pres_params)
    if @presentation.save
      @presentation.update_attribute(:Frei, $number.to_i)
      flash[:success] = "Präsentation #{@presentation.Titel} gespeichert"
      if Teacher.find_by(nv: params[:Betreuer]) == nil && Teacher.find_by(vn: params[:Betreuer]) != nil
        @presentation["Betreuer"] = Teacher.find_by(vn: params[:Betreuer]).Number
      elsif Teacher.find_by(nv: params[:Betreuer]) != nil && Teacher.find_by(vn: params[:Betreuer]) == nil
        @presentation["Betreuer"] = Teacher.find_by(nv: params[:Betreuer]).Number
      end
      @presentation.update_attribute(:Von, "#{Time.parse(row.Von).seconds_since_midnight}")
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
    upres.update_attribute(:Von, Time.parse(params[:von]).seconds_since_midnight)
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
    $time = (params[:time].to_i + 15) * 60
    pres.each do |time|
      time.update_attribute(:time, $time)
    end
    redirect_to admin_add_students_path
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
