class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log user in and redirect to user's show page
      # log_in is a sessions_helper method
      log_in user
      # this helper method will install a session cookie in the user's machine
      remember user
      redirect_to user
    else
      # create an error message and render new session page again
      flash.now[:danger] = 'Invalid email/password combination' #sorta
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
