class Admin::PostCommentsController < Admin::BaseController
  def index
    @post_comment = PostComment.all.page(params[:page]).per(20)
  end

  def destroy
    @post_comment = PostComment.find_by(id: params[:id])
  if @post_comment
    nickname = @post_comment.user.nickname
    @post_comment.destroy
    redirect_to admin_post_comments_path, notice: "#{nickname}さんのコメントを削除しました。"
  else
    redirect_to admin_post_comments_path, alert: "そのコメントは既に削除されています。"
  end
  end
end
