class Post < ApplicationRecord

    validates :title, presence: true
    validates :body, presence: true
    validates :user_id, presence: true
    validates :category_id, presence: true

    belongs_to :category
    belongs_to :user
    has_many :post_comments, dependent: :destroy
end
