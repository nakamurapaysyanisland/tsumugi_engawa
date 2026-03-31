class Public::GroupUsersController < ApplicationController
    before_action :authenticate_user!

    def create
        @group = Group.find(params[:group_id])
        @group_user = current_user.group_users.find_or_initialize_by(group_id: @group.id)
        if @group_user.save
            @group.create_notification_group_join!(current_user)
        end

        respond_to do |format|
            format.html { redirect_to post_path(@post)}
            format.js
        end
    end

    def destroy
        @group_user = GroupUser.find(params[:id])
        @group = @group_user.group 
        @group_user.destroy

        respond_to do |format|
            format.html { redirect_to group_path(@group), notice: "参加を取り消しました。" }
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
        if @group_user.update(status: 'accepted')
            @group.create_notification_group_accepted!(current_user, @group_user.user_id)
            redirect_to group_group_users_path(@group), notice: "グループへの参加を承認しました。"
        else
            redirect_to group_group_users_path(@group), notice: "グループへの承認に失敗しました。"
        end
    end
end
