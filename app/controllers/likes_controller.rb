class LikesController < ApplicationController
  skip_before_action :login_required

  def create
    @like = current_user.likes.new(user_id: current_user.id, topic_id: params[:topic_id])
    @like.save
    @topic = Topic.find_by(id: @like.topic_id)
  end

  def delete
    @like = current_user.likes.find_by(user_id: current_user.id, topic_id: params[:topic_id])
    @topic = Topic.find_by(id: @like.topic_id)
    @like.destroy
  end
end
