class Public::MembershipsController < ApplicationController
    def create
        @group = Group.find(params[:group_id])
        membership =current_user.memberships.new(group_id: params[:group_id])
        membership.save
    end

    def destroy
        membership = current_user.memberships.find_by(group_id: params[:group_id])
        membership.destroy




    
end
