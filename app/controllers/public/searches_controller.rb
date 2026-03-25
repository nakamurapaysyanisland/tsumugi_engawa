class Public::SearchesController < ApplicationController

skip_before_action :configure_authentication, only: [:search]
    def search
		@categories = Category.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		
		if @model == 'post'
			@posts = Post.search_for(@content, @method).page(params[:page]).per(12)
		elsif @model == 'user'
			@users = User.search_for(@content, @method).page(params[:page]).per(12)
		elsif @model == 'tag'
			@posts = Tag.search_posts_for(@content, @method).page(params[:page]).per(12)
		elsif @model == 'group'
			@groups = Group.search_for(@content, @method).page(params[:page]).per(12)
		end
	end
end
