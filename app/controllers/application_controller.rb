class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This will allow us to user the SessionsHelper module everywhere in out
  # application including in our views
  include SessionsHelper
end
