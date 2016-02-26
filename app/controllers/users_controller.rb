class UsersController < ApplicationController

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
      #handle successful save
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
