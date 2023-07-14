class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user, shallow: true

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    # @posts = Post.includes(:author)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    # @comments = @post.comments
    @comments = Comment.includes(:post)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
