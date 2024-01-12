# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def show
    @user = User.find(params[:user_id].to_i)
    @post = Post.find(params[:id].to_i)
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id].to_i)
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_posts_path(@post.author_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)

    if @post.destroy
      flash[:success] = 'Post was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to user_posts_path(@post.author_id), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
