class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
      # Log the user in and redirect to the user's profile/show page
      # Solely if both informations match
    else
      # Create error message if the params do not match the data base
      flash.now[:danger] = 'Invalid email/password or combination' #Try again
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to  root_url
  end
end
