# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(subject: 'Account activation', to: @user.email, &:html)
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end
end
