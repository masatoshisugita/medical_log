# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show edit update destroy]
  before_action :correct_topic, only: %i[edit update]

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
      flash[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @topic.comments
  end

  def edit; end

  def update
    if current_user.id == @topic.user_id && @topic.update(topic_params)
      flash[:success] = 'トピックを更新しました。'
      redirect_to @topic
    else
      flash.now[:danger] = '編集に失敗しました'
      render :edit
    end
  end

  def destroy
    if current_user.id == @topic.user_id
      @topic.destroy
      flash[:danger] = "「#{@topic.sick_name}」を削除しました。"
      redirect_to topics_url
    end
  end

  def search
    @search = params[:search] # viewに表示するため
    if @search.present?
      @topics = Topic.searching(params[:search])
      @topics = @topics.paginate(page: params[:page], per_page: 10)
      if @topics.blank?
        flash[:danger] = "「#{@search}」に一致する病名は現在ありません。"
        redirect_to root_url
      end
    else
      flash[:danger] = '病気の名前を入力してください。'
      redirect_to root_url
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:sick_name, :period, :initial_symptom, :content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def correct_topic
    if current_user.id != @topic.user_id
      flash[:danger] = 'こちらのURLにはアクセスできません。'
      redirect_to root_url
    end
  end
end
