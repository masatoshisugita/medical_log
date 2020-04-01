class LikesController < ApplicationController

  def create
    @topic = Topic.find(params[:id])
    @topic.nice(current_user)
  end

  def destroy
    @topic = Like.find(params[:id]).topic
    @topic.no_nice(current_user)
  end
end
