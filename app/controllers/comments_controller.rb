class CommentsController < ApplicationController
  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    @comment = @post.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(post_id: @post.id, author_id: current_user.id, text: comment_params)
    @comment.post_id = @post.id

    if @comment.save
      redirect_to user_post_path(current_user, @post.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)

    if @comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end

    redirect_to user_post_path(@comment.post.author_id, @comment.post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
