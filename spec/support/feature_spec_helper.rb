# frozen_string_literal: true

module FeatureSpecHelper
  def sign_in(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email.to_s
    fill_in 'パスワード', with: user.password.to_s
    click_button 'ログインする'
  end

  # def sign_out(user)
  #   delete logout_path, params: { session: { email: user.email,password: user.password } }
  # end

  def activate(user)
    user.update!(activated: true, activated_at: Time.current)
  end

  # other_userをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
