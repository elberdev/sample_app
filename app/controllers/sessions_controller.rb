class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # if user has been activated, log in, remember if applicable and redirect
      if @user.activated?
        # log user in and redirect to user's show page
        # log_in is a sessions_helper method
        log_in @user
        # the remember helper method will install a session cookie in the user's machine
        # if the user checks off the remember_me checkbox
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # session_helper method
        redirect_back_or(@user)
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # create an error message and render new session page again
      flash.now[:danger] = 'Invalid email/password combination' #sorta
      render 'new'
    end
  end

  def destroy
    # checks to see if we are logged in before logging out to avoid having any
    # nil errors
    log_out if logged_in?
    redirect_to root_url
  end

end
