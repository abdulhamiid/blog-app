class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @article = Post.new
  end

  def create
    @post = Post.new(article_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
