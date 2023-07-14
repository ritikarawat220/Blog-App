class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def sign_out_user
    sign_out current_user
    redirect_to root_path
  end
end
