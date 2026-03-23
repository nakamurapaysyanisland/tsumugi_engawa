class Admin::PostCommentsController < Admin::BaseController
  def index
    @post_comment = PostComment.all
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_comments_path, notice: '#{@user.nickname}さんのコメントを削除しました。'
  end
end
