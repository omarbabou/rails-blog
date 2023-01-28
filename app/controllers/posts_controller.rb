class PostsController < ApplicationController
  def index
    @user = all_users_post_controller
    @posts = @user.posts.includes(:comments).order('id asc')
  end

  def show
    @post = current_post
  end

  def new
    respond_to do |format|
      format.html { render :new, locals: { post: Post.new } }
    end
  end

  def create
    user = current_user
    post = Post.new(post_params)
    post.author = user
    if post.save
      flash[:success] = 'All Post were saved successfully'
      redirect_to user_posts_url
    else
      flash[:error] = 'Error: Could not save posts'
      redirect_to new_user_post_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
