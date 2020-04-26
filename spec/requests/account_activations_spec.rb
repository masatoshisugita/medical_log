require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  describe "#edit" do
    it "@userはアカウントを有効化できること" do
      @user = FactoryBot.create(:user)
      get edit_account_activation_path(@user.id)
      activate @user
      sign_in @user
      expect(response).to redirect_to user_path(@user)
    end
  end
end
