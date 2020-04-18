module RequestSpecHelpers
  def sign_in(user)
    post login_path, params: { session: { email: user.email,password: user.password } }
  end

  def activate(user)
    user.update!(activated: true, activated_at: Time.current)
  end

  #other_userをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
end
