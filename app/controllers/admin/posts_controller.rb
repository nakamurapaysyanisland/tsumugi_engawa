class Admin::PostsController < Admin::BaseController
  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
  end
  def destroy
    @Post.destroy
    redirect_to admin_post_path(@post), method: :destroy, notice: '#{@user.nickname}さんのコメントを削除しました。'
  end
end
