class SessionsController < ApplicationController

  def new
  end

  def create
    admin = Admin.find_by(number: params[:session][:number].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to adminhub_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
