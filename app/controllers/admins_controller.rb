class AdminsController < ApplicationController
  def hub
  end
  def show
    @admin = Admin.find(params[:id])
  end
end
