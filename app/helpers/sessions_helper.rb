module SessionsHelper

  # Logs in the given user. This method is used in the sessions_controller
  def log_in(user)
    # although permanent cookies are susceptible to a session hijacking attack,
    # this temporary cookie is encripted and is good to go. Cookie is automatically
    # destroyed once the browser is closed.
    session[:user_id] = user.id
  end

  # Remembers a user in a particular session.
  def remember(user)
    # creates a remember_token and a corresponding hashed remember_digest
    user.remember
    # creates a hashed cookie for user id with default expiration of 20 yrs.
    cookies.permanent.signed[:user_id] = user.id
    # creates a cookie with the remember_token with default expiration of 20 yrs.
    cookies.permanent[:remember_token] = user.remember_token
  end

  # returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  def log_out
    # deletes permanent session
    forget(current_user)
    # deletes temporary session
    session.delete(:user_id)
    # resets current_user to nil
    @current_user = nil
  end

  def current_user
    # if we have a temp session cookie, set current_user based on that
    if (user_id = session[:user_id])
      # We assign to the instance variable so we pull the id from
      # the stored cookie only once. We only assign if the variable
      # is currently nil.
      @current_user ||= User.find_by(id: session[:user_id])

    # otherwise look for a permanent session cookie. The cookies.signed method
    # decrypts the hashed id if there is a permanent cookie with a hashed
    # user_id.
    elsif (user_id = cookies.signed[:user_id])
      # This is a way to flag an area of code that is still untested. It will
      # raise a generic runtime exception. I can be deleted once the tests area
      # written.
      #raise
      user = User.find_by(id: user_id)
      # if there a user by that id and there is a matching permanent remember_token
      # cookie on the machine that matches its remember_digest ...
      if user && user.authenticated?(:remember, cookies[:remember_token])
        # log in the user first as there is no current temp session
        log_in user
        # set current_user to our user from the database
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session
  def forget(user)
    # sets user's remember_digest to nil
    user.forget
    # deletes all persistent cookies
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Redirects to stored location or default. To be used for friendly forwarding
  def redirect_back_or(default)
    # this evaluates to a forwarding url unless it's nil, in which case it
    # will use our default url, which is the user profile page
    redirect_to(session[:forwarding_url] || default)
    # delete temporary cookie with forwarding url info right after we use it
    # to prevent future unintended redirects
    session.delete(:forwarding_url)
  end

  # Stores the url trying to be accessed
  def store_location
    # store in a temporary cookie if there is a get request. This prevents a
    # GET redirect from happening by accident during POST, PATCH or DELETE requests.
    session[:forwarding_url] = request.url if request.get?
  end

end
