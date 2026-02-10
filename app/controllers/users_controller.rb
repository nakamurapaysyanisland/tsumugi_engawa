class UsersController < ApplicationController
 before_action :authenticate_user!


  def show
   @user = current_user
   @posts = @user.posts
   @user = User.find(params[:id])
  end

  def edit
    @user = current_user

  end

  def update
    @user = current_user
    if @user.update(user_params)
       bypass_sign_in(@user) 
      flash[:notice] = "ユーザー情報を更新しました。"
    redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def unsubscrilbe
  end

  def withdraw
  end

  def index
  end

  

  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :profile_image, :nickname, :password, :role, :status)
  end
end
