class LikesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @likes = @user.likes.all
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @user = @topic.user
    current_user.favorite(@topic)
  end

  def delete
    @topic = Topic.find(params[:topic_id])
    current_user.unfavorite(@topic)
  end
end
