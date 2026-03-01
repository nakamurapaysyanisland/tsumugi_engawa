class Public::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false
  def show
  end

  def index
    @categories = Category.all
  end
end
