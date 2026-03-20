class GroupUsersController < ApplicationController
    before_action :authenticate_user!

    def create
        @group = Group.find(params[:group_id])
        @membership = Membership.find(params[:membership_id])
        @group_user = GroupUser.create(user_id: @membership.user_id, group_id: params[:group_id])
        @membership.destroy
        redirect_to request.referer
    end


    end
