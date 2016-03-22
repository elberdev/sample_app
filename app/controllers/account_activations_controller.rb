class AccountActivationsController < ApplicationController

  def edit
    # the query that comes in from the link in the activation email will have a
    # token as the 'user id' and an escaped email. We will use these to find the
    # user and activate the account if appropriate

    user = User.find_by(email: params[:email])

    # must make sure to check if user has been activated already or not, b/c we
    # don't want an attacker who has gotten use of the email to get through to
    # the activation process' automatic login at the end, grabbing hold of
    # someone else's account.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
