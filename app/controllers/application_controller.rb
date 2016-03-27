class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # This will allow us to user the SessionsHelper module everywhere in out
  # application including in our views
  include SessionsHelper

  private

    # Before filter

    # confirms a logged-in user
    def logged_in_user
      unless logged_in?
        # store intended location to be used for friendly forwarding after
        # the user properly logs in
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
