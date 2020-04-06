class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:user_id,:post_id)
  end
end
