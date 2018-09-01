class PresentationsController < ApplicationController
  def list
    @presentations = Presentation.all
  end
  def show
  end
end
