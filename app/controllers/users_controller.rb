class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,:update,:destroy]
  skip_before_action :login_required, only: [:new,:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless @user.user_image.nil?
      @user.user_image.filename
    end

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "送信されたメールアドレスからアカウントを有効にしてください"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    flash[:success] = "ユーザー「#{@user.name}」を更新しました。"
    redirect_to @user
  end

  def destroy
    @user.destroy
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました。"
    redirect_to root_url
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
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:user_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
