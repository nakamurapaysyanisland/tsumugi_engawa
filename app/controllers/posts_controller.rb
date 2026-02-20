class PostsController < ApplicationController
 skip_before_action :authenticate_user!, only: [:index, :show], raise: false
 before_action :authenticate_user!, except: [:edit, :update, :destroy]
 before_action :ensure_current_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def index

    @posts = Post.includes(:user).all.order(created_at: :desc)
  @user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    
  end

  def update
     @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  def ensure_current_user
    @post = Post.find(params[:id])
     unless @post.user_id == current_user.id
      redirect_to posts_path, alert: "他のユーザーの投稿は編集・削除は出来ません。"
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
