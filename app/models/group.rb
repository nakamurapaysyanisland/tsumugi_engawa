class Group < ApplicationRecord
belongs_to :owner, class_name: 'User'

has_many :group_users, dependent: :destroy
has_many :users, through: :group_users
has_many :posts, dependent: :destroy
has_many :notifications, dependent: :destroy
has_one_attached :group_image

    validates :name, presence: true
    validates :introduction, presence: true
    validates :owner_id, presence: true

    

    def get_group_image(width, height)
    unless group_image.attached?
      return 'no_image.jpg'
    end
    group_image.variant(resize_to_limit: [width, height]).processed
    end

    def group_user_for(user)
      group_users.find_by(user_id: user.id)
    end

  def create_notification_group_approval!(current_user, member_id)
  notification = current_user.active_notifications.new(
    group_id: id,
    visited_id: current_user.id,
    action: 'group_approval'
  )
  notification.save if notification.valid?
end
end
