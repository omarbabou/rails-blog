class LikesController < ApplicationController
  def create
    user = current_user
    post = current_post
    post.likes.where("author_id = #{user.id}").length.positive? &&
      return
    like = Like.new(author: user, post: current_post)
    return unless like.save

    if params[:distination] == 'index'
      redirect_back_or_to user_posts_url
    else
      redirect_to new_user_post_like_url(id: post.id)
    end
  end
end
