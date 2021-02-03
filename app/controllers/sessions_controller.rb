# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
    if current_user
      flash[:danger] = 'こちらのURLにはアクセスするには、ログアウトが必要です。'
      redirect_to root_url
    end
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      if user.activated?
        log_in(user)
        flash[:info] = 'ログインしました'
        redirect_to user
      else
        flash[:warning] = '送信されたメールでアカウントを有効化してください'
        redirect_to root_url
      end
    else
      flash[:danger] = 'メールアドレスもしくはパスワードが有効ではありません'
      render :new
    end
  end

  def destroy
    reset_session
    flash[:info] = 'ログアウトしました。'
    redirect_to root_url
  end

  def new_guest
    user = User.find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example.com') do |u|
      u.password = SecureRandom.urlsafe_base64
      u.password_confirmation = u.password
    end

    log_in(user)
    flash[:info] = '「ゲストユーザー」としてログインしました'
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
