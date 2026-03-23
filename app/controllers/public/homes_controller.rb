class Public::HomesController < ApplicationController
  
    def top
  @latest_posts = Post.where(group_id: nil)
               .includes(:category, user: { profile_image_attachment: :blob })
               .order(created_at: :desc).limit(3)

  end
end
