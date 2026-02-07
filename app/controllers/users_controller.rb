class UsersController < ApplicationController


  def show
   @user = current_user
   @posts = @user.posts
  end

  def edit
  end

  def update
  end
  def unsubscrilbe
  end

  def withdraw
  end

  def index
  end

  def update
  end

  private
  def users_params
    params.require(:user).permit(:last_name, :first_name, :profile_image, :nickname)
  end
end
