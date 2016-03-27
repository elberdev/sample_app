class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # passing an empty array here keeps our app from breaking when the
      # user submits an invalid blank micropost. Not final implementation.
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    # request.referrer will redirect back to whatever page sent the request,
    # whether home page or user profile page
    redirect_to request.referrer || root_url
  end

  private

    # We define strong params here to allow only content to be edited through
    # the internet.
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    # this method attempts to find the associated post to be deleted inside
    # the user's list of microposts. If it's nil (not the logged in user's
    # micropost), redirect to root.
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
