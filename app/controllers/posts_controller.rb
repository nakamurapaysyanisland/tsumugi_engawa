class PostsController < ApplicationController
  def new
    @posts = Post.new
  end

  def index
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def posts_params
    params.require(:posts).permit(:title, :body)
  end
end
