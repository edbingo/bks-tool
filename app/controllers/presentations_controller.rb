class PresentationsController < ApplicationController
  def list
    @presentations = Presentation.all.order(:Name)
  end
  def show
  end
  def import
    Presentation.import(params[:file])
    flash.now[:success] = "Presentationen erfolgreich hinzugefügt"
    render 'addfree'
  end

  def addfree
    number = params[:free]
    pres = Presentation.all
    pres.each do |num|
      num.update_attribute(:Frei, number)
    end
    redirect_to admin_path
    flash[:success] = "Datenbank aktualisiert"
  end
end
