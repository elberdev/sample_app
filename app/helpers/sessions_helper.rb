module SessionsHelper

  # Logs in the given user. This method is used in the sessions_controller
  def log_in(user)
    # although permanent cookies are susceptible to a session hijacking attack,
    # this temporary cookie is encripted and is good to go. Cookie is automatically
    # destroyed once the browser is closed.
    session[:user_id] = user_id
  end

  def current_user
    # We assign to the instance variable so we pull the id from
    # the stored cookie only once. We only assign if the variable
    # is currently nil.
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
