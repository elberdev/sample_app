class UsersController < ApplicationController
  # we set the before action and which actions it will be used with.
  # scroll down to private section to see the method implementation
  before_action :logged_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #@user = User.new(params[:user])
    #not final implementation! this is dangerous because it passes
    #all parameters to User.new, allowing for malicious attacks
    #passing in this general hash is no longer the preferred method.
    #see private method below for a more specific and safer implementation

    @user = User.new(user_params)
    if @user.save
      # handle successful save by logging them in by default, flashing a
      # success message, and redirecting them to their user profile page.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # Rails automatically infers here that we are referring to @user's url
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # give confirmation of successful update
      flash[:success] = "Profile updated"
      # redirect to user's profile page
      redirect_to @user
    else
      # re-render the edit page
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # confirms a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
