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
  
  if @post
    @nickname = @post.user&.nickname || "ユーザー"
    @post.destroy
  end

  respond_to do |format|
    format.html { redirect_to admin_user_path, notice: "#{@nickname}さんの投稿を削除しました。" }
    format.js
  end
end
end