class Public::CategoriesController < ApplicationController
  skip_before_action :configure_authentication, only: [:index], raise: false
  def show
    @category = Category.find(params[:id])
    @post = Category.page(params[:page]).per(10)
  end

  def index
    @category = Category.all
  end
end
