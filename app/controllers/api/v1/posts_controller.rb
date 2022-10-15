module Api
  module V1
    module Api
      module V1
        class PostsController < AuthenticationController
          def index
            @user = User.find(params[:user_id].to_i)
            render json: @user.posts
          end

          def show
            @post = Post.find(params[:id])
            render json: @post
          end
        end
      end
    end
  end
end
