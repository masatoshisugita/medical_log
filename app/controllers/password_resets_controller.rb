# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  skip_before_action :login_required, only: %i[new edit create update]
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワード再設定のメールを送信しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'メールアドレスが登録されていません'
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render :new
    elsif @user.update(user_params)
      log_in(@user)
      flash[:success] = 'パスワードを変更しました'
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to root_url unless @user&.activated? && @user&.authenticated?(:reset, params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'パスワードの有効期限が切れています'
      redirect_to new_password_reset_url
    end
  end
end
