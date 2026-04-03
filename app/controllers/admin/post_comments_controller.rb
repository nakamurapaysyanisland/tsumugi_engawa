class Admin::PostCommentsController < Admin::BaseController

  def index
    @post_comment = PostComment.all.page(params[:page]).per(20)
  end

  def destroy
  @post_comment = PostComment.find_by(id: params[:id])
  @post = @post_comment.post 

  if @post_comment.blank?
    return render js: "alert('そのコメントは既に削除されています');"
  end
  
  if @post_comment
    @post_comment.destroy
  end

  respond_to do |format|
    format.html { redirect_to admin_post_path(@post), notice: "削除しました" }
    format.js
  end
end
end