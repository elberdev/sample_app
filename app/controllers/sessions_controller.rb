class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log user in and redirect to user's show page
    else
      # create an error message and render new session page again
      flash.now[:danger] = 'Invalid email/password combination' #sorta
      render 'new'
    end
  end

  def destroy
  end
end
