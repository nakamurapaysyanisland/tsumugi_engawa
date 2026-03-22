class Public::GroupUsersController < ApplicationController
    before_action :authenticate_user!
    def create
        @group = Group.find(params[:group_id])
        @group_user = current_user.group_users.find_or_initialize_by(group_id: @group.id)
        if @group_user.save
        @group.create_notification_group_approval!(current_user, @group.owner_id)
        end

        respond_to do |format|
            format.html { redirect_to post_path(@post)}
            format.js
        end
    end

    def destroy
        @group = Group.find(params[:group_id])
        @group_user = GroupUser.find(params[:id])
        @group_user =current_user.group_users.find(params[:id])
        @group_user.destroy

        respond_to do |format|
            format.html { redirect_to post_path(@post)}
            format.js
        end
    end

    def index
    @group = Group.find(params[:group_id])
    @group_users = @group.group_users.pending.page(params[:page])
   end

   def update
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.find(params[:id])
    if @group_user.update(status: 1)
        @group.create_notification_group_approval!(current_user, @group_user.user_id)
        redirect_to group_group_users_path(@group), notice: "グループへの参加を承認しました。"
    else
        redirect_to group_group_users_path(@group), notice: "グループへの承認に失敗しました。"
    end
    end
end
