class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to @user, notice:"タスク「#{@user.name}」を更新しました。"
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url, notice:"タスク「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password_confirmation)
  end
end
