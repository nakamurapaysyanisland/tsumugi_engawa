class Admin::PostsController < Admin::BaseController
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  if @post.nil?
    redirect_to admin_post_comments_path, alert: "その投稿は削除されたか、存在しません。"
  end
  end
  def destroy
    
    @post = Post.find_by(id: params[:id])
    nickname = @post.user.nickname
    @post.destroy
    redirect_to admin_post_comments_path(@post), method: :destroy, notice: "#{nickname}さんのコメントを削除しました。"
  end
end
