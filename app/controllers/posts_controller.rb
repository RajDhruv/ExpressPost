class PostsController < ApplicationController
	def home
		@owner=false
		params[:page]||=1
		@all_post,@count=Post.get_all_posts(params[:page])
		respond_to do |format|
			format.js{render partial:"post_redirection.js.erb", locals:{from: :home, page: params[:page]}}
			format.html{render template:"posts/home.html.erb", locals:{page: params[:page], from: "Home"}}
		end
	end
	def my_posts
		@owner=true
		params[:page]||=1
		@all_post,@count=Post.get_users_all_posts(params[:page],current_user)
		respond_to do |format|
			format.js{render partial:"post_redirection.js.erb", locals:{from: :my_posts, page: params[:page]}}
			format.html{render template:"posts/home.html.erb", locals:{page: params[:page], from: "Home"}}
		end
	end
	def new
		@post=Post.new
		render partial:"post_redirection.js.erb", locals:{from: :new}
	end
	def create
		@owner=true
		@post=Post.create(title: params[:post][:title], description: params[:post][:description], user:current_user)
		render partial:"post_redirection.js.erb", locals:{from: :create}
	end
	def edit
		@post=Post.find_by_id params[:id]
		render partial:"post_redirection.js.erb", locals:{from: :edit}
	end
	def update
		@owner=true
		@post=Post.find_by_id params[:id]
		@post.update_attributes(title: params[:post][:title], description: params[:post][:description])
		render partial:"post_redirection.js.erb", locals:{from: :update}
	end
	def delete
		@post=Post.find_by_id params[:id]
		ActiveRecord::Base.lock_optimistically=false
		@post.update_attribute("lock_version",-1)
		ActiveRecord::Base.lock_optimistically=true
		render partial:"post_redirection.js.erb", locals:{from: :delete}
	end
end