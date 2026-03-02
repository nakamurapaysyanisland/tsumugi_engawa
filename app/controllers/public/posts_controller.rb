class Public::PostsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show]
 before_action :ensure_current_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page])
      @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新に成功しました。"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user)
  end

 

  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def ensure_current_user
    @post = Post.find(params[:id])
     unless @post.user_id == current_user.id
      redirect_to posts_path, alert: "他のユーザーの投稿は編集・削除は出来ません。"
    end
  end
end
