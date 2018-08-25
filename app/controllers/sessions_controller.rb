class SessionsController < ApplicationController

  def new
  end

  def create
    admin = Admin.find_by(number: params[:session][:number].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to admin
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # Do some magic
  end

end
