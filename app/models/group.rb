class Group < ApplicationRecord
belongs_to :owner, class_name: 'User'

has_many :group_users, dependent: :destroy
has_many :users, through: :group_users
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
end
