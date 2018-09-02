class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end
  def hub
  end
  def show
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "Admin wurde registriert"
      redirect_to adminhub_path
    else
      render 'new'
    end
  end

  def list
    @admins = Admin.all
  end

  private

  def admin_params
    params.require(:admin).permit(:name,:vorname,:mail,:number,:password,:password_confirmation)
  end
end
