class CommentsController < ApplicationController
  before_action :current_user, only: [:create]

  def create
    @comment = current_user.comments.new(comments_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(current_user.id, Post.find(params[:post_id]))
    else
      render :new
      flash.now[:error] = 'Error: Comment could not be saved'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    post.decrement!(:comments_counter)
    comment = post.comments.find(params[:id])
    comment.destroy
    redirect_to user_post_path(user_id: params[:user_id], id: post)
  end

  private

  def comments_params
    params.require(:comment).permit(:Text)
  end
end
