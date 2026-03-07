class Public::SearchesController < ApplicationController

    def search
		@category = Category.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]

		if @model == 'post'
			@records = Post.search_for(@content, @method)
		elsif @model == 'user'
			@records = User.search_for(@content, @method)
		elsif @model == 'tag'
			@records = Tag.search_posts_for(@content, @method)
		end
	end
end
