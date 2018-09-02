class PresentationsController < ApplicationController
  def list
    @presentations = Presentation.all
  end
  def show
  end
  def import
    Presentation.import(params[:file])
    redirect_to admin_url
    flash[:success] = "Presentationen erfolgreich hinzugefügt"
  end
end
