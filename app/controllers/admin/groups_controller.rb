class Admin::GroupsController < Admin::BaseController
  
  def index
    @groups = Group.all.order(created_at: :desc).page(params[:page]).per(17)
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order(created_at: :desc).page(params[:page]).per(5)
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