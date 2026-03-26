class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
                                 .includes(:visitor, :visited, :post, :group)
                                 .order(created_at: :desc)
                                 .page(params[:page])
                                 .per(20)
    @notifications.where(checked: false).update_all(checked: true)
  end

  def destroy
    @notification = current_user.passive_notifications.find(params[:id])
    @notification.destroy
    redirect_to notifications_path, notice: "通知を削除しました。"
  end
end
