class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @comment = current_user.comments.new(comment_params)
      @comment.update_comments_counter
      respond_to do |format|
        flash[:notice] = if @comment.save
                           'Comment created Successfully'
                         else
                           'something went wrong'
                         end
        format.html { redirect_to request.path }
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      @post = @comment.post
    end
  
    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :text)
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
