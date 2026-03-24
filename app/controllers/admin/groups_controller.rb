class Admin::GroupsController < Admin::BaseController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @group = Group.find_by(id: params[:id])
    @posts = @group.posts.page(params[:page]).per(10)
    @post_comment = PostComment.find(params[:id])
  end
end