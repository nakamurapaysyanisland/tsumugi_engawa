class Public::PostsController < ApplicationController
 skip_before_action :configure_authentication, only: [:index, :show]
 before_action :ensure_current_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def index
    if params[:category_id].present?
    @category = Category.find(params[:category_id])
    @posts = @category.posts.where(group_id: nil).page(params[:page]).per(10)
  else
    @posts = Post.where(group_id: nil).order(created_at: :desc).page(params[:page]).per(12)
  end
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
      if @post.group_id.present? #postの中にgroup_idはある？
        redirect_to group_path(@post.group_id), notice: "投稿に成功しました。"
      else
      redirect_to post_path(@post), notice: "投稿に成功しました。"
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    respond_to do |format|
    format.html { redirect_to posts_path, notice: '投稿を削除しました' }
    format.js   
  end
  end

 

  private
  def post_params
    params.require(:post).permit(:title, :body, :category_id, :group_id)
  end

  def ensure_current_user
    @post = Post.find(params[:id])
     unless @post.user_id == current_user.id
      redirect_to posts_path, alert: "他のユーザーの投稿は編集・削除は出来ません。"
    end
  end
end
