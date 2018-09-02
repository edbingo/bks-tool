class PresentationsController < ApplicationController
  def list
    @presentations = Presentation.all
  end
  def show
  end
  def import
    Presentation.import(params[:file])
    redirect_to adminhub_url
    flash[:success] = "File uploaded successfully"
  end
end
