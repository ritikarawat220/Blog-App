class CommentsController < ApplicationController
  load_and_authorize_resource :post
  # before_action :set_user_and_post
  load_and_authorize_resource :comment, through: :post
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(current_user, @post)
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    @user = current_user
    redirect_to user_post_path(@user, @post)
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
