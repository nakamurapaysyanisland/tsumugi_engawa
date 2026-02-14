class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  before_save :destroy_posts_if_withdrawn, if: -> { status_changed? && withdrawn? }

  validates :nickname, presence: true, uniqueness: true
  validates :last_name, :first_name, :email, presence: true, unless: :guest?
  validates :password, presence: true, length: { minimum: 6 }, unless: :guest?

  enum status: { active: 0, withdrawn: 1 }
  enum role: { guest: 0, member: 1, admin: 2 }
  
  before_validation :set_default_role, on: :createrails 

  def get_profile_image(width, height)
    unless profile_image.attached?
      return 'no_image.jpg'
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def password_required?
    super && !guest?
  end

  def email_required?
    super && !guest?
  end

  def active_for_authentication?
    super && status != "withdrawn"
  end
private
def set_default_role
  self.role ||= :guest
end

def destroy_posts_if_withdrawn
    posts.destroy_all
  end


end