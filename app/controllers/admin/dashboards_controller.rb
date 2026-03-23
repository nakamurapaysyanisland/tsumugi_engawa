class Admin::DashboardsController < Admin::BaseController
    

    def index
        @users = User.all
    end
    def destroy
        @user = User.find(params[:id]) 
        @user.destroy
        redirect_to admin_dashboard_path, notice: "ユーザーを削除しました。"
    end
end
