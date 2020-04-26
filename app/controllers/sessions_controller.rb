class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      if user.activated?
        log_in(user)
        flash[:info] = "ログインしました"
        redirect_to user
      else
        flash[:warning] = "送信されたメールでアカウントを有効化してください"
        redirect_to root_url
      end
    else
      flash[:danger] = "メールアドレスもしくはパスワードが有効ではありません"
      render :new
    end
  end

  def destroy
    reset_session
    flash[:info] = "ログアウトしました。"
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email,:password)
  end

end
