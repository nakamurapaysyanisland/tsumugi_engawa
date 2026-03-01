class Admin::CommentsController < ApplicationController
  def index
    @user = User.find(params[:id])
  end

  def destroy
  end
end
