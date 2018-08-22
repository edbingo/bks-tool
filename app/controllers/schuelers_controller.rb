class SchuelersController < ApplicationController
  def new
    @schueler = Schueler.new
  end

  def show
  @schuelers = Schueler.find(params[:id])
  end

  def create
    @schueler = Schueler.new
  end
end
