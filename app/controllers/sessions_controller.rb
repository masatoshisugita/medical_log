class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      if user.activated?
        log_in(user)
        redirect_to user, notice:'ログインしました。'
      else
        flash[:warning] = "送信されたメールでアカウントを有効化してください"
        redirect_to root_url
      end
    else
      flash[:danger] = "ユーザー登録をしてください"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url,notice:'ログアウトしました。'
  end


  private

  def session_params
    params.require(:session).permit(:email,:password)
  end

end
