class Admin::DashboardsController < Admin::BaseController
    

    def index
        @users = User.all.page(params[:page]).per(20)
    end
end
