class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
    render json: @user.posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      render json: @post, status: :created, location: @band
      redirect_to user_posts_path(@post.author_id)
    else
      render json: @post.errors, status: :unprocessable_entity
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
