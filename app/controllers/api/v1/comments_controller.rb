module Api
  module V1
    class Api::V1::CommentsController < AuthenticationController 
      def index
        @user = User.find(params[:user_id].to_i)
        @post = @user.posts
        render json: @post.comments
      end
    
      def show
        @post = Post.find(params[:id])
        render json: @post
      end
    end
  end
end