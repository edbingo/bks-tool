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
      if Teacher.find_by(nv: @presentation.Betreuer) == nil && Teacher.find_by(vn: @presentation.Betreuer) != nil
        @presentation["Betreuer"] = Teacher.find_by(vn: @presentation.Betreuer).Number
        @presentation.update_attribute(:Frei, $number.to_i)
        @presentation.update_attribute(:Von, "#{Time.parse(@presentation.Von).seconds_since_midnight}")
        @presentation["Bis"] = "#{Time.parse(@presentation.Bis).seconds_since_midnight}"
        @presentation.update_attribute(:time, Presentation.first.time)
        redirect_to admin_show_presentations_path
      elsif Teacher.find_by(nv: @presentation.Betreuer) != nil && Teacher.find_by(vn: @presentation.Betreuer) == nil
        @presentation["Betreuer"] = Teacher.find_by(nv: @presentation.Betreuer).Number
        @presentation.update_attribute(:Frei, $number.to_i)
        @presentation.update_attribute(:Von, "#{Time.parse(@presentation.Von).seconds_since_midnight}")
        @presentation["Bis"] = "#{Time.parse(@presentation.Bis).seconds_since_midnight}"
        @presentation.update_attribute(:time, Presentation.first.time)
        redirect_to admin_show_presentations_path
      elsif Teacher.find_by(nv: @presentation.Betreuer) == nil && Teacher.find_by(vn: @presentation.Betreuer) == nil && Teacher.find_by(Number: @presentation.Betreuer) != nil
        @presentation["Betreuer"] = Teacher.find_by(Number: @presentation.Betreuer)
        @presentation.update_attribute(:Frei, $number.to_i)
        @presentation.update_attribute(:Von, "#{Time.parse(@presentation.Von).seconds_since_midnight}")
        @presentation["Bis"] = "#{Time.parse(@presentation.Bis).seconds_since_midnight}"
        @presentation.update_attribute(:time, Presentation.first.time)
        redirect_to admin_show_presentations_path
      elsif Teacher.find_by(nv: params[:Betreuer]) == nil && Teacher.find_by(vn: params[:Betreuer]) == nil && Teacher.find_by(Number: params[:Betreuer]) == nil
        flash[:danger] = "Dieser Lehrer wurde nicht gefunden"
        @presentation.destroy
        render 'new'
      end
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
    upres.update_attribute(:Bis, Time.parse(params[:bis]).seconds_since_midnight)
    redirect_to admin_show_presentations_path
  end

  def show
  end

  def import
    Presentation.import(params[:file]) # Import presentation from file parameters
    flash.now[:success] = "Es wurden #{$numpres} Präsentationen hinzugefügt, und #{$errpres} wurden nicht importiert"
    render 'addfree'
  end

  def addfree # Set available spaces per presentation
    $number = params[:free]
    pres = Presentation.all
    pres.each do |num|
      num.update_attribute(:Frei, $number)
    end
    $time = params[:time].to_i * 60
    pres.each do |time|
      time.update_attribute(:time, $time)
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
    params.require(:presentation).permit(:Name,:Vorname,:Klasse,:Titel,:Fach,:Betreuer,:Zimmer,:Von,:Bis,:Datum)
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
