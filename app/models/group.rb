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

 def self.search_for(content, method)
        Group.where("name LIKE ? OR introduction LIKE ?", "%#{content}%", "%#{content}%")
    end

  def search
    @model = params[:model]
  @content = params[:content]

  if @model == 'group' && !user_signed_in?
    flash[:alert] = "コミュニティ機能を利用するにはログインが必要です"
    redirect_to new_user_session_path
    return 
  end
end
def is_owned_by?(user)
  owner_id == user.id
end

def is_member?(user)
  return false if user.nil?
  group_users.exists?(user_id: user.id)
end

def includes_user?(user)
  group_users.exists?(user_id: user.id, status: 'accepted')
end
end
