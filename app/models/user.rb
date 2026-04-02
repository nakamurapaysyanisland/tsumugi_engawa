class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id'
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  attr_accessor :registering_as_member

  validates :nickname, presence: true, uniqueness: true
 
  with_options if: :registering_as_member do
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :email, presence: true
    validates :password, presence: true, length: { minimum: 6 }, on: :create
    validates :password_confirmation, presence: true, on: :create
  end

  def password_required?
    registering_as_member || (super && !guest?)
  end

  def email_required?
    registering_as_member || !guest?
  end

  enum status: { active: 0, withdrawn: 1 }
  enum role: { guest: 0, member: 1, admin: 2 }
  
  before_validation :set_default_status, on: :create
  before_save :destroy_posts_if_withdrawn, if: -> { status_changed? && withdrawn? } 
  before_save :check_role
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      return 'no_image.jpg'
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def inactive_message
    active? ? super : :withdrawn_account 
  end

  def guest_user?
    self.guest? 
  end

  def active_for_authentication?
    super && (new_record? || !withdrawn?)
  end

  private
  
  def set_default_status
    self.role ||= :guest
    self.status ||= :active
  end

  def destroy_posts_if_withdrawn
    posts.destroy_all
  end

  
  def check_role
    if last_name.present? && first_name.present? && email.present?
      self.role = 'member' if self.role == 'guest'
    end
  end

  def self.search_for(content, method)
      User.where('nickname LIKE ?', '%'+content+'%')
  end

  def finalize_role
    if registering_as_member || (last_name.present? && first_name.present?)
      self.role = :member
    else
      self.role ||= :guest
    end
    self.status ||= :active
  end
end

