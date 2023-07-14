class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:posts]

  def posts
    @posts = @user.posts
    render json: @posts
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
