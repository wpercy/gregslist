class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.tag = params[:tag]
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to @micropost
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def show
    @micropost = Micropost.find(params[:id])
    @tag = Tag.find_by(name: @micropost.tag)
    @comments = @micropost.comments
    if signed_in?
      @comment = current_user.comments.build
    end
    @coords= Geocoder.search(@micropost.user.location)
  end

  def index
    @microposts = Micropost.all
  end

  private

    def micropost_params
      params.require(:micropost).permit(:post_title, :content, :tag, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
