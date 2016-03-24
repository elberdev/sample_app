class UsersController < ApplicationController
  # we set the before action and which actions it will be used with.
  # scroll down to private section to see the method implementation
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  # make sure we have the correct user before carrying out any edit or update
  before_action :correct_user,   only: [:edit, :update]
  # make sure only an adimin can access the destroy action itself
  before_action :admin_user,     only: [:destroy]

  # action to show all users
  def index
    # calling the paginate method returns users in chunks of 30 by default
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    # we need to define this variable here in order for our pagination of
    # microposts to work in the user profile page.
    @microposts = @user.microposts.paginate(page: params[:page])
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
      # handle successful save by starting account activation process and
      # redirecting them to the root path
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      # Rails automatically infers here that we are referring to @user's url
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    # don't need this anymore because @user is now defined in correct_user
    # method before any action is taken on the edit and update methods
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      # notice admin? is conspicuously missing from the permit key list. We do
      # not want anyone to be able to change that parameter on the interwebs. It
      # would be a huge security hole.
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

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

    # confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      # current_user?() is a sessions_helper method. The user of the params hash has
      # to match the current user or will be redirected to root
      redirect_to(root_url) unless current_user?(@user)
    end

    # confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
