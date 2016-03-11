ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Returns true if a test user is logged in. Method name is not logged_in? so as
  # to not be confused with the app/helpers/sessions_helper.rb method of that name.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user
  def log_in_as(user, options = {})

    # these variables are assigned a default value if the hashes aren't present
    password    = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'

    # log in method will be different depending on whether it's an integration test
    # or not.
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  private

    # Returns true inside an integration test
    def integration_test?
      defined?(post_via_redirect)
    end

end
