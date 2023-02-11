class CommentsController < ApplicationController
  def new
    respond_to do |format|
      format.html { render :new, locals: { comment: Comment.new } }
    end
  end

  def create
    user = current_user
    post = current_post
    comment = Comment.new(comment_params)
    comment.author = user
    comment.post = post
    if comment.save
      flash[:success] = 'Comments were saved successfully'
      redirect_to user_post_url(id: post.id)
    else
      flash[:error] = 'Error: Could not save comments'
      redirect_to new_user_post_comment_url
    end
  end

  private

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.comments_counter -= 1
    @comment.destroy!
    redirect_to user_post_path(id: @post.id), notice: 'Comment was successfully deleted!'
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
  
    def create
      user = current_user
      post = current_post
      comment = Comment.new(comment_params)
      comment.author = user
      comment.post = post
      if comment.save
        flash[:success] = 'Comments were saved successfully'
        redirect_to user_post_url(id: post.id)
      else
        flash[:error] = 'Error: Could not save comments'
        redirect_to new_user_post_comment_url
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
