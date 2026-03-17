class Public::HomesController < ApplicationController
  def top
    @latest_posts = Post.where(group_id: nil).limit(3).order(created_at: :desc)
  end
end
