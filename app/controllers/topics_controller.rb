class TopicsController < ApplicationController
  before_action :set_current_user_topic, only: [:edit,:update,:destroy]


  def index
    @topics = Topic.paginate(page: params[:page], per_page: 5)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      flash[:success] = "「#{@topic.sick_name}」を登録しました。"
      redirect_to @topic
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
  end

  def update
    @topic.update!(topic_params)
    flash[:success] = "「#{@topic.sick_name}」を更新しました。"
    redirect_to @topic
  end

  def destroy
    @topic.destroy
    flash[:danger] = "「#{@topic.sick_name}」を削除しました。"
    redirect_to topics_url
  end

  def search
    @search = params[:search]
    @topics = Topic.search(params[:search])
  end

  private

  def topic_params
    params.require(:topic).permit(:sick_name,:period,:initial_symptom,:content)
  end

  def set_current_user_topic
    @topic = current_user.topics.find(params[:id])
  end
end
