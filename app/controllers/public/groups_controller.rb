class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :membership]

  def index
    @groups = Group.all
  end

  def new
    @group =Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: 'コミュニティーを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
    if @group.nil?
      redirect_to groups_path, alert: "グループが見つかりませんでした。"
    end
    @post = Post.new
    @posts = @group.posts.page(params[:page]).per(10)
    @post_comment = PostComment.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def memberships
    @group = Group.find(params[:id])
    @memberships = @group.memberships.page(params[:page])
  end
  private
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to group_path(@group), alert: "グループオーナーのみ編集が可能です。"
    end
  end

end
