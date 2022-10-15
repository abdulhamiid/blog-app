module Api
  module V1
    class Api::V1::CommentsController < AuthenticationController 
      def index
        @user = User.includes(posts: [:comments]).find(params[:user_id])
        @post = @user.posts.find_by(id: params[:post_id])
        @comment = @post.comments
        render json: @comment
      end
    
      def new
        @comment = Comment.new
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.new(post_id: @post.id, author_id: current_user.id, text: comment_params)
        @comment.post_id = @post.id
        
        render json: @comment if @comment.save
      end

      def comment_params
        params.require(:comment).permit(:text)[:text]
      end
    end
  end
end
