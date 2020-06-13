# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AccountActivations', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '#edit' do
    it '@userはアカウントを有効化できること' do
      get edit_account_activation_path(@user.activation_token, email: @user.email)
      expect(flash[:success]).to eq 'アカウントを有効化しました'
      expect(response).to redirect_to user_path(@user)
    end

    it 'tokenが正しく無い時、アカウントを有効化できないこと' do
      get edit_account_activation_path('wrong token', email: @user.email)
      expect(flash[:danger]).to eq 'アカウントの有効化に失敗しました'
      expect(response).to redirect_to root_url
    end

    it 'emailが正しく無い時、アカウントを有効化できないこと' do
      get edit_account_activation_path(@user.activation_token, email: 'abc@example.com')
      expect(flash[:danger]).to eq 'アカウントの有効化に失敗しました'
      expect(response).to redirect_to root_url
    end
  end
end
