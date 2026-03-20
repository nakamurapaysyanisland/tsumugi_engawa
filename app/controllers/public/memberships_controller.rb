class Public::MembershipsController < ApplicationController
    def create
        @group = Group.find(params[:group_id])
        membership = current_user.membership.new(group_id: params[:group_id])
        membership.save
        redirect_to request.referer, notice: "グループへの参加申請をしました。"
    end

    def destroy
        membership = current_user.membership.find_by(group_id: params[:group_id])
        membership.destroy
        redirect_to request.referer, alert: "グループへの参加申請を取り消しました。"
    end


    
end
