class SchuelersController < ApplicationController
  def new
    @schueler = Schueler.new
  end

  def show
    @schuelers = Schueler.find(params[:id])
  end

  def create
    @schueler = Schueler.new(schueler_params)
    if @schueler.save
      flash[:success] = "User successfully registered"
      redirect_to @schueler
    else
      render 'new'
    end
  end

  private

    def schueler_params
      params.require(:schueler).permit(:vorname, :name, :mail, :klasse, :number)
    end
end
