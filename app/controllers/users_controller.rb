# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :login_required, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_image&.filename

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = '送信されたメールアドレスからアカウントを有効にしてください'
      redirect_to root_url
    else
      flash[:danger] = '正確な値を入力してください'
      render :new
    end
  end

  def show
    @topics = @user.topics.all
  end

  def edit; end

  def update
    if @user.update(user_params)
      @user.user_image&.filename
      flash[:success] = 'ユーザーを編集しました。'
      redirect_to @user
    else
      flash[:danger] = '正確な値を入力してください'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました。"
    redirect_to root_url
  end

  # @userがフォローしているユーザーを表示するメソッド
  def following
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  # @userをフォローしているユーザーを表示するメソッド
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
