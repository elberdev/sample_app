module SessionsHelper

  # Logs in the given user. This method is used in the sessions_controller
  def log_in(user)
    # although permanent cookies are susceptible to a session hijacking attack,
    # this temporary cookie is encripted and is good to go. Cookie is automatically
    # destroyed once the browser is closed.
    session[:user_id] = user_id
  end

end
