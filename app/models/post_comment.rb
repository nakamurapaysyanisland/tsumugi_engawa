class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
  has_many :notifications, dependent: :destroy

  def create_notification_comment!(current_user)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      comment_id: id,    
      visited_id: post.user_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end