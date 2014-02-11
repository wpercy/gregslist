class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    @all_users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @history = session[:history]
  end 

  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      ApiKey.create!(user_id: @user.id)
      sign_in @user
      flash[:success] = "Welcome to Gregslist!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @tags = Tag.pluck(:name)
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      @user.favorites = @user.favorites.take(@user.favorites.length - 1)
      @user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @tags=Tag.pluck(:name)
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :location, :favorites => [])
    end

    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
