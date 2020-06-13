# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  before do
    @user = FactoryBot.create(:user)
    activate @user
  end

  describe '#new' do
    it 'viewを表示できること' do
      get new_password_reset_path
      aggregate_failures do
        expect(response).to have_http_status '200'
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create' do
    it '有効な値の時、メールが送信できること' do
      expect { post password_resets_path, params: { password_reset: { email: @user.email.to_s } } }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it '無効な値の時、メールを送信できないこと' do
      expect { post password_resets_path, params: { password_reset: { email: 'abc@gmail.com' } } }.not_to change { ActionMailer::Base.deliveries.count }
    end
  end

  describe '#edit' do
    before do
      @user.create_reset_digest
    end

    it 'viewを表示できること' do
      get edit_password_reset_path(@user.reset_token, email: @user.email)
      aggregate_failures do
        expect(response).to have_http_status '200'
        expect(response).to render_template(:edit)
      end
    end

    it 'reset_tokenが正しく無い時、リダイレクトすること' do
      get edit_password_reset_path('abc', email: @user.email)
      expect(response).to redirect_to(root_url)
    end

    it 'emailが正しく無い時、リダイレクトすること' do
      get edit_password_reset_path(@user.reset_token, email: 'abc@example.com')
      expect(response).to redirect_to(root_url)
    end
  end

  describe '#update' do
    before do
      @user.create_reset_digest
    end

    it '有効な値の時、passwordを再設定できること' do
      patch password_reset_path(@user.reset_token), params: { email: @user.email, user: { password: 'password', password_confirmation: 'password' } }
      aggregate_failures do
        expect(response).to redirect_to(@user)
        expect(flash[:success]).to eq 'パスワードを変更しました'
        expect(session[:user_id]).to eq @user.id
      end
    end

    it 'passwordが無効な時、passwordを再設定できないこと' do
      patch password_reset_path(@user.reset_token), params: { email: @user.email, user: { password: 'abcdef', password_confirmation: 'password' } }
      expect(flash[:danger]).to eq 'パスワードとパスワード（確認）を正しく入力して下さい'
      expect(response).to render_template(:edit)
    end

    it 'passwordが空の時、passwordを再設定できないこと' do
      patch password_reset_path(@user.reset_token), params: { email: @user.email, user: { password: '', password_confirmation: 'password' } }
      expect(flash[:danger]).to eq 'パスワードとパスワード（確認）を正しく入力して下さい'
      expect(response).to render_template(:edit)
    end
  end
end
