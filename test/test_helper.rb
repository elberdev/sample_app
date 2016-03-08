ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...

  # Returns true if a test user is logged in. Method name is not logged_in? so as
  # to not be confused with the app/helpers/sessions_helper.rb method of that name.
  def is_logged_in?
    !session[:user_id].nil?
  end
  
end
