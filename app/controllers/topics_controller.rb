class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to @topic, notice: "「#{@topic.sick_name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments
  end

  def edit
    @topic = current_user.topics.find(params[:id])
  end

  def update
    @topic = current_user.topics.find(params[:id])
    @topic.update!(topic_params)
    redirect_to @topic, notice:"タスク「#{@topic.sick_name}」を更新しました。"
  end

  def destroy
    @topic = current_user.topics.find(params[:id])
    @topic.destroy
    redirect_to topics_url, notice:"タスク「#{@topic.sick_name}」を削除しました。"
  end

  def search
    @search = params[:search]
    @topics = Topic.search(params[:search])
  end

  private

  def topic_params
    params.require(:topic).permit(:sick_name,:period,:initial_symptom,:content)
  end
end
