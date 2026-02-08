class Post < ApplicationRecord

    validates :title, presence: true
    validates :body, presence: true
    validates :user_id, presence: true
    validates :category, presence: true

    belongs_to :category
    belongs_to :user
end
