class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!

    def index
        @user = User.all
    end
end
