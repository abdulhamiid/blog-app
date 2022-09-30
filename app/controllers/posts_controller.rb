class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def show
    @user = User.find(params[:user_id].to_i)
    @post = Post.find(params[:id])
  end
end
