class Admin::UsersController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!


     def show
        @user = User.find(params[:id])
    end
    def withdraw
        @user = User.find(params[:id])
        @user.update(status: :withdrawn)
        redirect_to admin_dashboards_path, notice: "#{@user.nickname}様を退会させました。"
    end
   
end
