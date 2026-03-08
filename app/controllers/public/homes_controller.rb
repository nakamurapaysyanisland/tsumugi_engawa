class Public::HomesController < ApplicationController
  def top
    @latest_posts = Post.limit(3).order(created_at: :desc)
  end
end
