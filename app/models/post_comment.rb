class PostComment < ApplicationRecord

    belongs_to :post
    belongs_to :user
    validates :content, presence: true

    def create
  @post = Post.find(params[:post_id])
  @comment = current_user.post_comments.new(post_comment_params)
  @comment.post_id = @post.id
  if @comment.save
  
    @post.create_notification_comment!(current_user, @comment.id)

  end
end
end
