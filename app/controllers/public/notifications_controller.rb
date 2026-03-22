class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(:post).order(creaated_at: :desc)
  
    @notifications.where(checked: false).each do |notificatoin|
      @notifications.update(checked: true)
    end
  end
end
