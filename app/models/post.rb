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
    has_many :notifications, dependent: :destroy

    def self.search_for(content, method)
        Post.where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
    end

    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end

    def create_notification_comment!(current_user, post_comment_id)
 
      return if user_id == current_user.id

      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: post_comment_id,
        visited_id: user_id,
        action: 'comment'
      )
        notification.save if notification.valid?
    end
  
    def create_notification_favorite!(current_user)
      return if user_id == current_user.id
  
        notification = current_user.active_notifications.find_or_create_by(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

        notification.save if notification.new_record? && notification.valid?
      end
    end
  
end
