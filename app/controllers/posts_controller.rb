class PostsController < ApplicationController
    def index
        @user = all_posts
        @posts = @user.posts.order('id asc')
      end
    
      def show
        @post = current_post
      end
    end
end
