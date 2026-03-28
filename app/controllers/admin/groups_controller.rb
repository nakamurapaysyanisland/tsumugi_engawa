class Admin::GroupsController < Admin::BaseController
  def index
    @groups = Group.all.page(params[:page]).per(17)
  end

  def show
    @group = Group.find(params[:id])
    @group = Group.find_by(id: params[:id])
    @posts = @group.posts.page(params[:page]).per(10)
    
  end
  def destroy
  @group = Group.find(params[:id])
  if @group.destroy
    redirect_to admin_groups_path, notice: "グループ「#{@group.name}」を削除しました。"
  else
    redirect_to admin_group_path(@group), alert: "削除に失敗しました。"
  end
end
end