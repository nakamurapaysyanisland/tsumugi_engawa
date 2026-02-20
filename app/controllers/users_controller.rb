class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :guest_check, only: [:destroy]

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
  
  def create
    @user = User.new(user_params)
    @user.role = :guest
    if @user.save
      redirect_to mypage_path, notice: "ユーザー登録が完了しました。"
    else
      render :new
    end
  end
  def unsubscrilbe
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(status: :withdrawn)
    @user.posts.destroy_all
    redirect_to new_user_registration_path, notice: "退会処理が完了しました。またのご利用をお待ちしております。"
  end

  def index
  end

  def mypage
    @user = current_user
    @posts = @user.posts
    
  end

  def create_guest
    @user = User.new(guest_params)
    @user.role = :guest
    @user.email = "guest_#{Time.now.to_i}#{rand(1000)}@example.com"
    @user.password = SecureRandom.alphanumeric(10)
    if @user.save
      session[:user_id] = @user.id
      redirect_to mypage_path, notice: "ゲストユーザーとしてログインしました。"
    else
      render :new_guest
    end
  end
 
  def edit_upgrade
    @user = current_user
  end

  def upgrade
    @user = current_user
    if @user.update(user_upgrade_params.merge(role: :member))
      redirect_to mypage_path, notice: "会員登録が完了しました。"
    else
      render :edit_upgrade
    end
  end

  def build_resource(hash = {})
    super
    resource.role = :member if action_name == 'create'
  end

  def guest_check
    if current_user.email == "guest_#{Time.now.to_i}#{rand(1000)}@example.com"
      redirect_to mypage_path, alert: "ゲストユーザーはこの操作はできません。"
    end
  end 
  private
  def user_params
    params.require(:user).permit(:last_name, :first_name,:email, :profile_image, :nickname, :password, :password_confirmation, :role, :status)
  end

  def guest_params
    params.require(:user).permit(:nickname)
  end

  def user_upgrade_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation, :profile_image, :nickname, :role, :status)
  end
end