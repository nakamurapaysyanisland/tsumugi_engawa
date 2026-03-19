class Public::PostCommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = current_user.post_comments.new(post_comment_params)
        @comment.post_id = @post.id
        if @comment.save
        else
            @comment.errors.full_messages
        end
    end
    def destroy
        @post = Post.find(params[:post_id])
        comment = current_user.post_comments.find(params[:id])
        comment.destroy

        respond_to do |format|
            format.html { redirect_to post_path(@post)}
            format.js
        end
    end
    private
    def post_comment_params
        params.require(:post_comment).permit(:content)
    end
end
