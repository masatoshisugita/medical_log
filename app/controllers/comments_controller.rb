# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
    else
      flash[:danger] = '自分以外のコメントは削除できません'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:review, :user_id, :post_id)
  end
end
