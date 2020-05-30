# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  before do
    @user = FactoryBot.create(:user)
    activate @user
  end

  describe '#new' do
    it '200レスポンスを返すこと' do
      get login_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#create' do
    context '有効な値なら' do
      it 'ログインできること' do
        get login_path
        post login_path, params: { session: { email: @user.email, password: @user.password } }
        expect(response).to redirect_to(@user)
      end
    end
    context '無効な値なら' do
      it 'ログインできないこと' do
        get login_path
        post login_path, params: { session: { email: @user.email, password: 'aaabbb' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    context 'ログインユーザーなら' do
      it 'ログアウトできること' do
        sign_in @user
        delete logout_path, params: { session: { email: @user.email, password: @user.password } }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
