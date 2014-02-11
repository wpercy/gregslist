class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost]
    if @comment.save
      flash[:success] = "Comment posted"
      redirect_to Micropost.find(params[:micropost])
    else
      flash[:fail] = "failed to post: " + @comment.content
      render 'static_pages/home'
    end
  end

  def destroy
    session[:return_to] ||= request.referer
	  @comment.destroy
    redirect_to session.delete(:return_to)
  end

  def show
    @comment = Comment.find(params[:id])
  end

private

    def comment_params
      params.require(:comment).permit(:content, :micropost)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
