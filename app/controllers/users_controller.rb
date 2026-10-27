class UsersController < ApplicationController
  def index
    @users = User.includes(:user_image_attachment).all
  end

  def show
    @user = User.find(params[:id])
  end
end
