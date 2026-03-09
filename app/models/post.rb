class Post < ApplicationRecord

    validates :title, presence: true
    validates :body, presence: true
    validates :user_id, presence: true
    validates :category, presence: { message: "を選択してください" }

    belongs_to :category, optional: true
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_many :favarites, dependent: :destroy

    def self.search_for(content, method)
        Post.where("title LIKE ? OR body LIKE ?", "%#{content}%", "%#{content}%")
    end

      def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
