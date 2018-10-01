class TeachersController < ApplicationController
  before_action :logged_in_stud
  helper_method :sort_col, :sort_dir
  require 'prawn'

  def download_pdf
    teac = Teacher.find_by(Number: $tid)
    pres = Presentation.where(Betreuer: $tid)
    send_data generate_pdf(teac,pres),
      filename: "#{teac.Vorname}_#{teac.Name}_praesenzliste.pdf",
      type: "application/pdf"
  end

  def list
    teac = Teacher.all
    @teacher = Teacher.order("#{sort_col} #{sort_dir}")
  end

  def edit
    id = params[:id]
    $newteac = Teacher.find_by(id: id)
  end

  def pres
    $tid = params[:number]
    if $tid == nil
      redirect_to admin_show_teachers_path
    else
      @teac = Teacher.find_by(Number: $tid)
      @teaclist = Presentation.where(Betreuer: @teac.Number)
      if @teaclist.first == nil
        flash[:danger] = "Keine Präsentationen verfügbar"
        redirect_to admin_show_teachers_path
      else
        render 'preslist'
      end
    end
  end

  def update
    uteac = Teacher.find_by(id: $newteac.id)
    uteac.update_attribute(:Vorname, params[:vorname])
    uteac.update_attribute(:Name, params[:name])
    uteac.update_attribute(:Mail, params[:mail])
    uteac.update_attribute(:Number, params[:number])
    redirect_to admin_show_teachers_path
  end

  def deleter
    id = params[:id]
    Teacher.find_by(id: id).destroy
    redirect_to admin_show_teachers_path
    flash[:success] = "Lehrer wurde erfolgreich entfernt"
  end

  def logged_in_stud
    unless logged_ad?
      flash[:danger] = "Diese Seite ist nur für Admins verfügbar"
      redirect_to admin_login_path
    end
  end

  def new
    @teacher = Teacher.new
  end

  def import
    Teacher.import(params[:file])
    redirect_to admin_add_students_url
    flash[:success] = "Lehrer erfolgreich hinzugefügt"
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash[:success] = "Lehrer wurde registriert"
      redirect_to admin_show_teachers_path
    else
      render 'new'
    end
  end

  def remove
    @teacher = if params[:term]
      Teacher.where('Name LIKE ?', "%#{params[:term]}")
    else
      Teacher.all.order(:Name)
    end
  end

  def tentf
    num = params[:number]
    Teacher.find_by(Mail: num).destroy
    redirect_to admin_path
    flash[:success] = "Lehrer wurde erfolgreich entfernt"
  end

  private

  def teacher_params
    params.require(:teacher).permit(:Name,:Mail,:Number,:Vorname)
  end

  def sortable_cols
    ["Vorname", "Name", "Mail", "Number"]
  end

  def sort_col
    sortable_cols.include?(params[:col]) ? params[:col] : "Vorname"
  end

  def sort_dir
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "asc"
  end

  def generate_pdf(teac,pres)
    Prawn::Document.new do
      text "#{teac.Vorname} #{teac.Name}", align: :center
      text "Ihre Präsentationen"
      table([
        ["Name","Titel","Zimmer","Zeit","Datum"],
        [pres.collect{ |r| [r.Name] },
         pres.collect{ |r| [r.Titel] },
         pres.collect{ |r| [r.Zimmer] },
         pres.collect{ |r| [Time.at(r.Von.to_i).utc.strftime("%H:%M")] },
         pres.collect{ |r| [r.Datum] }]
        ])
      move_down 20
      pres.each do |pres|
        text "Besucher '#{pres.Titel}':"
        text "#{pres.Besucher}"
        move_down 20
      end
    end.render
  end

end
