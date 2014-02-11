class TagsController < ApplicationController
  before_action :signed_in_user, only: [:create, :new]
  before_action :admin_user, only: [:create, :new]

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "Tag created successfully."
      redirect_to @tag
    else
      render 'new'
    end
  end

  def new
    @tag = Tag.new
  end

  def destroy
    @tag = Tag.find(params[:id])
    # Destroy all microposts listed under this tag
    @posts = Micropost.where("tag = ?", @tag.name)
    @posts.each do |post|
      post.destroy
    end
    
    @tag.destroy

    flash[:success] = "Tag deleted."
    redirect_to tags_url
  end

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @user=current_user

    if signed_in?
      @micropost = current_user.microposts.build
    end
    @microposts = Micropost.where("tag = ?", @tag.name)
  end

  def search
    require 'will_paginate/array'
    @microposts = Micropost.search(params[:search]).paginate(page: params[:page], per_page: 1)
  end

  private
    def tag_params
      params.require(:tag).permit(:name, :search)
    end
end
