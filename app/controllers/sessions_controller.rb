class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      logged user
    else
      flash.now[:danger] = t "controller.sessions.wrongmail_password"
      render :new
    end
  end

  def logged user
    log_in user
    remember_me = params[:session][:remember_me]
    if remember_me == Settings.remember_yes
      remember user
    else
      forget user
    end
    redirect_back_or user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

