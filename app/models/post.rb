class Post < ApplicationRecord

    validates :title, presence: true
    validates :body, presence: true
    validates :user_id, presence: true
    validates :category, presence: { message: "を選択してください" }, if: -> { group_id.blank? }
    


    belongs_to :category, optional: true
    belongs_to :user
    belongs_to :group, optional: true
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    def self.search_for(content, method)
        Post.where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
    end

      def favorited_by?(user)
    favorites.exists?(user_id: user.id)
    end

    def create_notification_like!(current_user)
  
  temp = Notification.where(["visitor_id = ? AND visited_id = ? AND post_id = ? AND action = ? ", current_user.id, user_id, id, 'like'])
  
  
  if temp.blank?
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id, 
      action: 'like'
    )
    
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

  def create_notification_comment!(current_user, comment_id)

  notification = current_user.active_notifications.new(
    post_id: id,
    comment_id: comment_id,
    visited_id: user_id,
    action: 'comment'
  )

  if notification.visitor_id == notification.visited_id
    notification.checked = true
  end
  notification.save if notification.valid?
end

def create_notification_group_approval!(current_user, member_id)
  notification = current_user.active_notifications.new(
    group_id: id,
    visited_id: member_id,
    action: 'group_approved'
  )
  notification.save if notification.valid?
end
end
