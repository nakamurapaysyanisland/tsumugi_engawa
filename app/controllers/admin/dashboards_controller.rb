class Admin::DashboardsController < Admin::BaseController
    

    def index
        @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
    end
end
