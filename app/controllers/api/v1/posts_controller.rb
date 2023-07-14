class Api::V1::PostsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_post, only: %i[comments create_comment]

  def index
    @posts = @user.posts
    render json: @posts
  end

  def comments
    @comments = @post.comments
    render json: @comments
  end

  def create_comment
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
