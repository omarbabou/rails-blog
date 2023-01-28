class PostsController < ApplicationController
    def index
        @user = all_users_post_controller
        @posts = @user.posts.includes(:comments).order('id asc')
      end
  
    def show
