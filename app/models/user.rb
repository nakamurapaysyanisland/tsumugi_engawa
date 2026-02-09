class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  validates :nickname, presence: true, uniqueness: true
  
  enum status: { active: 0, inactive: 1 }
  enum role: { guest: 0, member: 1, admin: 2 }
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    return 'no_image.jpg'
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

end