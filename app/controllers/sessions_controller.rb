class SessionsController < ApplicationController
  before_action :authenticate


  def new
  end

  def create
    admini = Admin.find_by(number: params[:session][:number].downcase)
    if admini && admini.authenticate(params[:session][:password])
      # Log in
    else
      render "new"
    end
  end

  def destroy
    # Do some magic
  end

end
