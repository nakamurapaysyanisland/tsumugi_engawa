class Public::GroupsController < ApplicationController
  def index
    @group = Group.all
    @post = Post.all
  end

  def new
    @group =Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner.user_id = current.user_id
    if @group.save
      redirect_to group_path, notice: 'コミュニティーを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end
