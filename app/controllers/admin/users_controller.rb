class Admin::UsersController < Admin::BaseController
    layout 'admin'
    before_action :authenticate_admin!
    before_action :set_user, only: [:show, :withdraw]

     def show
        @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(12)
    end
    
    def withdraw
        @user.update(status: :withdrawn)
        redirect_to admin_dashboards_path, notice: "#{@user.nickname}様を退会させました。"
    end
   
    private

    def set_user
        @user = User.find(params[:id])
    end
end
