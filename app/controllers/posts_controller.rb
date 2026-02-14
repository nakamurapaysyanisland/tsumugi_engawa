class PostsController < ApplicationController
 skip_before_action :authenticate_user!, only: [:index], raise: false

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

  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
