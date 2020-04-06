class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,:update,:destroy]
  skip_before_action :login_required, only: [:new,:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_url, notice: "「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.update!(user_params)
    redirect_to @user, notice:"タスク「#{@user.name}」を更新しました。"
  end

  def destroy
    @user.destroy
    redirect_to root_url, notice:"タスク「#{@user.name}」を削除しました。"
  end

  #@userがフォローしているユーザーを表示するメソッド
  def following
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  #@userをフォローしているユーザーを表示するメソッド
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
