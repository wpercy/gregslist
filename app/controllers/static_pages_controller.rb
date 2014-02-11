class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @feed_items = current_user.favorites_feed.paginate(page: params[:page])
      @recent_items = current_user.recents_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def favorites
    @user=current_user
    @tag=Tag.find_by(name: @user.favorites)
  end

  def about
  end

  def contact
  end

  def terms
  end
end
