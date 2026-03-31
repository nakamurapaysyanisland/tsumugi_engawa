class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.where(group_id: nil)
            .includes(:category, user: { profile_image_attachment: :blob })
            .order(created_at: :desc).limit(6)
  end
end
