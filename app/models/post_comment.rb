class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
  has_many :notifications, foreign_key: 'comment_id', dependent: :destroy

   
       
end